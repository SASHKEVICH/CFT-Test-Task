//
//  PasswordRegistrationViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import UIKit

protocol PasswordRegistrationViewControllerProtocol: AnyObject {
    var presenter: PasswordRegistrationPresenterProtocol? { get set }
    func showPasswordErrorLabel()
    func hidePasswordErrorLabel()
    func showPasswordConfirmationErrorLabel()
    func hidePasswordConfirmationErrorLabel()
    func enableConfirmRegistrationButton()
    func disableConfirmRegistrationButton()
}

final class PasswordRegistrationViewController: UIViewController, PasswordRegistrationViewControllerProtocol {
    private let topStackView = ShiftCustomStackView()
    private let passwordTextField = ShiftCustomTextField()
    private let passwordConfirmationTextField = ShiftCustomTextField()
    private let passwordErrorLabel = ShiftCustomLabel()
    private let passwordConfirmationLabel = ShiftCustomLabel()
    private let confirmRegistrationButton = ShiftCustomButton()
    
    private let viewsHeight: CGFloat = 60
    
    private var passwordConfirmationTextFieldTopConstraint: NSLayoutConstraint?
    
    var presenter: PasswordRegistrationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Регистрация"
        setupTopStackView()
        setupTextFields()
        setupErrorLabels()
        setupConfirmRegistrationButton()
    }
}

extension PasswordRegistrationViewController {
    func showPasswordErrorLabel() {
        passwordConfirmationTextFieldTopConstraint?.constant = 100
        toggleAppearence(errorLabel: passwordErrorLabel, shouldHidden: false)
    }
    
    func hidePasswordErrorLabel() {
        passwordConfirmationTextFieldTopConstraint?.constant = 30
        toggleAppearence(errorLabel: passwordErrorLabel, shouldHidden: true)
    }
    
    func showPasswordConfirmationErrorLabel() {
        toggleAppearence(errorLabel: passwordConfirmationLabel, shouldHidden: false)
    }
    
    func hidePasswordConfirmationErrorLabel() {
        toggleAppearence(errorLabel: passwordConfirmationLabel, shouldHidden: true)
    }
    
    func enableConfirmRegistrationButton() {
        guard confirmRegistrationButton.buttonState != .normal else { return }
        confirmRegistrationButton.buttonState = .normal
    }
    
    func disableConfirmRegistrationButton() {
        guard confirmRegistrationButton.buttonState != .disabled else { return }
        confirmRegistrationButton.buttonState = .disabled
    }
    
    private func toggleAppearence(errorLabel: ShiftCustomLabel, shouldHidden: Bool) {
        guard errorLabel.isHidden != !errorLabel.isHidden else { return }
        UIView.animate(withDuration: 0.3) { [weak self, errorLabel] in
            guard let self = self else { return }
            if errorLabel == self.passwordErrorLabel {
                self.view.layoutIfNeeded()
            }
        }
        
        UIView.transition(with: errorLabel, duration: 0.3, options: [.curveEaseOut],
            animations: { [errorLabel] in
                errorLabel.alpha = shouldHidden ? 0 : 1
            },
            completion: { [errorLabel] _ in
                errorLabel.isHidden = shouldHidden
            })
        
        errorLabel.isHidden = shouldHidden
    }
}

// MARK: Setup top red stack view
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
}

// MARK: - Setup text fields
private extension PasswordRegistrationViewController {
    func setupTextFields() {
        setupPasswordTextField()
        setupPasswordConfirmationTextField()
    }
    
    func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.placeholder = "Ваш пароль*"
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: viewsHeight)
        ])
        
        passwordTextField.delegate = presenter?.textFieldHelper
        passwordTextField.type = .password
        passwordTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
    
    func setupPasswordConfirmationTextField() {
        view.addSubview(passwordConfirmationTextField)
        passwordConfirmationTextField.placeholder = "Повторите пароль*"
        passwordConfirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordConfirmationTextFieldTopConstraint = NSLayoutConstraint(
            item: passwordConfirmationTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: passwordTextField,
            attribute: .bottom,
            multiplier: 1,
            constant: 30)
        self.passwordConfirmationTextFieldTopConstraint = passwordConfirmationTextFieldTopConstraint
    
        NSLayoutConstraint.activate([
            passwordConfirmationTextFieldTopConstraint,
            passwordConfirmationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordConfirmationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordConfirmationTextField.heightAnchor.constraint(equalToConstant: viewsHeight)
        ])
        
        passwordConfirmationTextField.delegate = presenter?.textFieldHelper
        passwordConfirmationTextField.type = .password
        passwordConfirmationTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
}

// MARK: - Setup error labels
private extension PasswordRegistrationViewController {
    func setupErrorLabels() {
        setupPasswordErrorLabel()
        setupPasswordConfirmationErrorLabel()
    }
    
    func setupPasswordErrorLabel() {
        view.addSubview(passwordErrorLabel)
        passwordErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10)
        ])
        
        passwordErrorLabel.text = "Пароль должен быть длинной от 8 до 16 символов, содержать цифры от 1 до 9, букву в верхнем и в нижнем регистре."
        passwordErrorLabel.numberOfLines = 0
        passwordErrorLabel.isHidden = true
    }
    
    func setupPasswordConfirmationErrorLabel() {
        view.addSubview(passwordConfirmationLabel)
        passwordConfirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordConfirmationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordConfirmationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordConfirmationLabel.topAnchor.constraint(equalTo: passwordConfirmationTextField.bottomAnchor, constant: 10)
        ])
        
        passwordConfirmationLabel.text = "Пароли не совпадают."
        passwordConfirmationLabel.numberOfLines = 0
        passwordConfirmationLabel.isHidden = true
    }
}
    
// MARK: - Setup confirm registration button
private extension PasswordRegistrationViewController {
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
        confirmRegistrationButton.buttonState = .disabled
        confirmRegistrationButton.addTarget(self, action: #selector(didTapConfirmRegistrationButton), for: .touchUpInside)
    }
}

private extension PasswordRegistrationViewController {
    @objc
    func didChangeTextField(_ textField: UITextField) {
        guard let textField = textField as? ShiftCustomTextField else { return }
        let trimmedPassword = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        switch textField {
        case passwordTextField:
            presenter?.didChangePasswordTextField(text: trimmedPassword)
        case passwordConfirmationTextField:
            presenter?.didChangePasswordConfirmationTextField(text: trimmedPassword)
        default:
            return
        }
    }
}

private extension PasswordRegistrationViewController {
    @objc
    func didTapConfirmRegistrationButton() {
        presenter?.didTapConfirmRegistrationButton()
    }
}
