//
//  DateRegistrationViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import UIKit

protocol DateRegistrationViewControllerProtocol: AnyObject {
    var presenter: DateRegistrationViewPresenterProtocol? { get set }
    func showBirthdateErrorLabel()
    func hideBirthdateErrorLabel()
    func enableContinueRegistrationButton()
    func disableContinueRegistrationButton()
}

final class DateRegistrationViewController: UIViewController, DateRegistrationViewControllerProtocol {
    private let topStackView = ShiftCustomStackView()
    private let birthdateView = ShiftBirthdateView()
    private let continueRegistrationButton = ShiftCustomButton()
    private let birthdateErrorLabel = ShiftCustomLabel()
    
    private let viewsHeight: CGFloat = 60
    
    var presenter: DateRegistrationViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Регистрация"
        setupTopStackView()
        setupBirthdateView()
        setupBirthdateErrorLabel()
        setupContinueRegistrationButton()
    }
}

// MARK: - DateRegistrationViewControllerProtocol
extension DateRegistrationViewController {
    func showBirthdateErrorLabel() {
        guard birthdateErrorLabel.isHidden != !birthdateErrorLabel.isHidden else { return }
        birthdateErrorLabel.isHidden = false
    }
    
    func hideBirthdateErrorLabel() {
        guard birthdateErrorLabel.isHidden != !birthdateErrorLabel.isHidden else { return }
        birthdateErrorLabel.isHidden = true
    }
    
    func enableContinueRegistrationButton() {
        guard continueRegistrationButton.buttonState != .normal else { return }
        continueRegistrationButton.buttonState = .normal
    }
    
    func disableContinueRegistrationButton() {
        guard continueRegistrationButton.buttonState != .disabled else { return }
        continueRegistrationButton.buttonState = .disabled
    }
}

// MARK: - Setup top red stack view
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

// MARK: - Setup birthdate view
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
        
        birthdateView.delegate = presenter?.datePickerDelegate
    }
}

// MARK: - Setup birthdate error label
private extension DateRegistrationViewController {
    func setupBirthdateErrorLabel() {
        view.addSubview(birthdateErrorLabel)
        birthdateErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            birthdateErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            birthdateErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            birthdateErrorLabel.topAnchor.constraint(equalTo: birthdateView.bottomAnchor, constant: 10)
        ])
        
        birthdateErrorLabel.text = "Дата рождения не может быть больше текущей даты."
        birthdateErrorLabel.numberOfLines = 0
        birthdateErrorLabel.isHidden = true
    }
}

// MARK: - Setup continue registration button
private extension DateRegistrationViewController {
    func setupContinueRegistrationButton() {
        view.addSubview(continueRegistrationButton)
        continueRegistrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            continueRegistrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueRegistrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueRegistrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            continueRegistrationButton.heightAnchor.constraint(equalToConstant: viewsHeight)
        ])
        
        continueRegistrationButton.title = "Продолжить"
        continueRegistrationButton.buttonState = .disabled
        continueRegistrationButton.addTarget(self, action: #selector(didTapConfirmRegistrationButton), for: .touchUpInside)
    }
}

private extension DateRegistrationViewController {
    @objc
    func didTapConfirmRegistrationButton() {
        presenter?.didTapContinueRegistrationButton()
        
        let textFieldHelper = RegistrationTextFieldHelper()
        let passwordVC = PasswordRegistrationViewController()
        let passwordPresenter = PasswordRegistrationViewPresenter(
            textFieldHelper: textFieldHelper,
            registrationService: RegistrationService.shared)
        
        passwordVC.presenter = passwordPresenter
        passwordPresenter.view = passwordVC
        
        navigationController?.pushViewController(passwordVC, animated: true)
    }
}
