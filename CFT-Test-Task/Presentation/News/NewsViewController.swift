//
//  NewsViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import UIKit
import SafariServices

public protocol NewsViewControllerProtocol: AnyObject {
    var presenter: NewsViewPresenterProtocol? { get set }
    func didUpdateNewsAnimated(newsCount: Int, batchAmount: Int)
    func showActivityIndicator()
    func hideActivityIndicator()
    func showNewsInSafari(with url: URL)
    func showGreetings()
}

final class NewsViewController: UIViewController, NewsViewControllerProtocol {
    private let newsTableView = UITableView(frame: .zero, style: .insetGrouped)
    private let activityIndicatorView = UIActivityIndicatorView()
    
    var presenter: NewsViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Новости"
        presenter?.requestNews()
        
        setupNewsTableView()
        setupActivityIndicatorView()
        setupLogoutButton()
    }
}

// MARK: - NewsViewControllerProtocol
extension NewsViewController {
    func didUpdateNewsAnimated(newsCount: Int, batchAmount: Int) {
        newsTableView.performBatchUpdates { [weak self] in
            let newsIndexPaths = (newsCount - batchAmount..<newsCount).map { IndexPath(row: $0, section: 0) }
            self?.newsTableView.insertRows(at: newsIndexPaths, with: .automatic)
        } completion: { _ in }
    }
    
    func showActivityIndicator() {
        activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    
    func showNewsInSafari(with url: URL) {
        let vc = SFSafariViewController(url: url)
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    func showGreetings() {
        let greetingsViewController = GreetingsViewController()
        let greetingsViewPresenter = GreetingsViewPresenter(registrationService: RegistrationService.shared)
        
        greetingsViewPresenter.view = greetingsViewController
        greetingsViewController.presenter = greetingsViewPresenter
        
        greetingsViewController.modalPresentationStyle = .formSheet
        present(greetingsViewController, animated: true)
    }
}

// MARK: - Setup News table view
private extension NewsViewController {
    func setupNewsTableView() {
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        newsTableView.backgroundColor = .clear
        newsTableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        newsTableView.delegate = presenter?.tableViewHelper
        newsTableView.dataSource = presenter?.tableViewHelper
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.register(NewsTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsTableViewHeaderView.identifier)
    }
}

// MARK: - Setup Activitity indicator view
private extension NewsViewController {
    func setupActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 50),
            activityIndicatorView.heightAnchor.constraint(equalTo: activityIndicatorView.widthAnchor),
        ])
        
        activityIndicatorView.backgroundColor = .white
    }
}

// MARK: - Setup Logout button
private extension NewsViewController {
    func setupLogoutButton() {
        guard let buttonImage = UIImage(systemName: "rectangle.portrait.and.arrow.right") else { return }
        let logoutButton = UIBarButtonItem(
            image: buttonImage,
            style: .plain,
            target: self,
            action: #selector(didTapLogoutButton))
        
        logoutButton.tintColor = .shiftRed
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc
    func didTapLogoutButton() {
        let alertController = UIAlertController(
            title: "Выход",
            message: "Действительно хотите выйти?",
            preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.presenter?.didTapLogoutButton()
            self.switchToRegistrationCheckerViewController()
        }
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "Нет", style: .cancel) { _ in }
        alertController.addAction(noAction)
        
        present(alertController, animated: true)
    }
    
    private func switchToRegistrationCheckerViewController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("cannot get window")
            return
        }
        
        let registrationCheckerViewController = RegistrationCheckerViewController()
        let registrationCheckerPresenter = RegistrationCheckerPresenter(
            registrationService: RegistrationService.shared)
        
        registrationCheckerPresenter.view = registrationCheckerViewController
        registrationCheckerViewController.presenter = registrationCheckerPresenter
        
        window.rootViewController = registrationCheckerViewController
        window.makeKeyAndVisible()
    }
}
