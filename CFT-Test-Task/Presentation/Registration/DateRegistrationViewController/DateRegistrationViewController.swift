//
//  DateRegistrationViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import UIKit

final class DateRegistrationViewController: UIViewController {
    private let topStackView = ShiftCustomStackView()
    
    private let birthdateView = ShiftBirthdateView()
    private let confirmRegistrationButton = ShiftCustomButton()
    
    private let viewsHeight: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Регистрация"
        setupTopStackView()
        setupBirthdateView()
        setupConfirmRegistrationButton()
    }
}

private extension DateRegistrationViewController {
    func setupTopStackView() {
        view.addSubview(topStackView)
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.redViewsCount = 2
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topStackView.widthAnchor.constraint(equalToConstant: 140),
            topStackView.heightAnchor.constraint(equalToConstant: 4),
            topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])   
    }
}

private extension DateRegistrationViewController {
    func setupBirthdateView() {
        view.addSubview(birthdateView)
        birthdateView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            birthdateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            birthdateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            birthdateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            birthdateView.heightAnchor.constraint(equalToConstant: viewsHeight)
        ])
    }
}

private extension DateRegistrationViewController {
    func setupConfirmRegistrationButton() {
        view.addSubview(confirmRegistrationButton)
        confirmRegistrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            confirmRegistrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmRegistrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmRegistrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            confirmRegistrationButton.heightAnchor.constraint(equalToConstant: viewsHeight)
        ])
        
        confirmRegistrationButton.title = "Продолжить"
        confirmRegistrationButton.buttonState = .normal
        confirmRegistrationButton.addTarget(self, action: #selector(didTapConfirmRegistrationButton), for: .touchUpInside)
    }
}

private extension DateRegistrationViewController {
    @objc
    func didTapConfirmRegistrationButton() {
        print("tap")
        let passwordVC = PasswordRegistrationViewController()
        navigationController?.pushViewController(passwordVC, animated: true)
    }
}
