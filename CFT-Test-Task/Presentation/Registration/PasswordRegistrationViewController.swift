//
//  PasswordRegistrationViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import UIKit

final class PasswordRegistrationViewController: UIViewController {
    private let topStackView = ShiftCustomStackView()
    
    private let passwordTextField = ShiftCustomTextField()
    private let passwordConfirmationTextField = ShiftCustomTextField()
    
    private let confirmRegistrationButton = ShiftCustomButton()
    
    private let viewsHeight: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Регистрация"
        setupTopStackView()
        setupTextFields()
        setupConfirmRegistrationButton()
    }
}

private extension PasswordRegistrationViewController {
    func setupTopStackView() {
        view.addSubview(topStackView)
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.redViewsCount = 3
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topStackView.widthAnchor.constraint(equalToConstant: 140),
            topStackView.heightAnchor.constraint(equalToConstant: 4),
            topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setupTextFields() {
        view.addSubview(passwordTextField)
        passwordTextField.placeholder = "Ваш пароль*"
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(passwordConfirmationTextField)
        passwordConfirmationTextField.placeholder = "Повторите пароль*"
        passwordConfirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [passwordTextField, passwordConfirmationTextField].forEach {
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                $0.heightAnchor.constraint(equalToConstant: viewsHeight)
            ])
        }
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            passwordConfirmationTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
        ])
    }
    
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

private extension PasswordRegistrationViewController {
    @objc
    func didTapConfirmRegistrationButton() {
        print("tap")
    }
}
