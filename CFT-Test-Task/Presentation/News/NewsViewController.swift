//
//  NewsViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import UIKit
import SafariServices

protocol NewsViewControllerProtocol: AnyObject {
    var presenter: NewsViewPresenterProtocol? { get set }
    func didUpdateNewsAnimated(newsCount: Int, batchAmount: Int)
    func showActivityIndicator()
    func hideActivityIndicator()
    func showNewsInSafari(with url: URL)
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
