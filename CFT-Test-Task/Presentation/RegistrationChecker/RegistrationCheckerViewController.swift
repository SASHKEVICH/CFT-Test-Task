//
//  RegistrationCheckerViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import UIKit

protocol RegistrationCheckerViewControllerProtocol: AnyObject {
    var presenter: RegistrationCheckerPresenterProtocol? { get set }
    func switchToRegistrationViewController()
    func switchToContestsViewController()
}

final class RegistrationCheckerViewController: UIViewController, RegistrationCheckerViewControllerProtocol {
    private let imageView = UIImageView()
    private let activityIndicatorView = UIActivityIndicatorView()
    
    var presenter: RegistrationCheckerPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupImageView()
        setupActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear()
    }
}

// MARK: - Setup views
private extension RegistrationCheckerViewController {
    func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        imageView.image = UIImage(named: "CFTImageLogo")
        imageView.contentMode = .scaleAspectFit
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 50),
            activityIndicatorView.heightAnchor.constraint(equalTo: activityIndicatorView.widthAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        activityIndicatorView.backgroundColor = .white
        activityIndicatorView.layer.cornerRadius = 3
        activityIndicatorView.layer.masksToBounds = true
        
        activityIndicatorView.startAnimating()
    }
}

// MARK: - Switching to other view controllers
extension RegistrationCheckerViewController {
    func switchToRegistrationViewController() {
        activityIndicatorView.stopAnimating()
        
        let registrationViewController = getRegistrationViewController()
        registrationViewController.modalPresentationStyle = .fullScreen
        present(registrationViewController, animated: true)
    }
    
    func switchToContestsViewController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("cannot get window")
            return
        }
        
        activityIndicatorView.stopAnimating()
        
        let contestsViewController = getContestsViewController()
        window.rootViewController = contestsViewController
        window.makeKeyAndVisible()
    }
}

private extension RegistrationCheckerViewController {
    func getRegistrationViewController() -> UINavigationController {
        guard let presenter = presenter else {
            assertionFailure("presenter is nil")
            return UINavigationController()
        }
        
        let nameRegistrationViewController = presenter.getNameRegistrationViewController()
        let navigationController = UINavigationController(
            rootViewController: nameRegistrationViewController)
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .shiftRed
        
        return navigationController
    }
    
    func getContestsViewController() -> UINavigationController {
        guard let presenter = presenter else {
            assertionFailure("presenter is nil")
            return UINavigationController()
        }
        
        let contestsViewController = presenter.getContestsViewController()
        let navigationController = UINavigationController(
            rootViewController: contestsViewController)
        
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
