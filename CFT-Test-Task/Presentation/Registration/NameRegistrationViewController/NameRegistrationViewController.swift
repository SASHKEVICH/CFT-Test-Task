//
//  NameRegistrationViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 20.04.2023.
//

import UIKit

protocol NameRegistrationViewControllerProtocol: AnyObject {
    var presenter: NameRegistrationPresenterProtocol? { get set }
    func showNameErrorLabel()
    func hideNameErrorLabel()
    func showSurnameErrorLabel()
    func hideSurnameErrorLabel()
    func enableContinueRegistrationButton()
    func disableContinueRegistrationButton()
}

final class NameRegistrationViewController: UIViewController, NameRegistrationViewControllerProtocol {
    private let nameTextField = ShiftCustomTextField()
    private let surnameTextField = ShiftCustomTextField()
    
    private let nameErrorLabel = ShiftCustomLabel()
    private let surnameErrorLabel = ShiftCustomLabel()
    
    private let continueRegistrationButton = ShiftCustomButton()
    
    private let viewsHeight: CGFloat = 60
    
    private var surnameTextFieldTopConstraint: NSLayoutConstraint?
    
    var presenter: NameRegistrationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Регистрация"
        
        setupRedTopView()
        setupContinueRegistrationButton()
        setupTextFields()
        setupErrorLabels()
    }
}

// MARK: - Layout Views
private extension NameRegistrationViewController {
    func setupRedTopView() {
        let redView = UIView()
        redView.backgroundColor = .shiftRed
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            redView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redView.widthAnchor.constraint(equalToConstant: 140),
            redView.heightAnchor.constraint(equalToConstant: 4),
        ])
    }
    
    func setupTextFields() {
        view.addSubview(nameTextField)
        nameTextField.placeholder = "Ваше имя"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(surnameTextField)
        surnameTextField.placeholder = "Ваша фамилия"
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.delegate = presenter?.textFieldHelper
        surnameTextField.delegate = presenter?.textFieldHelper
        nameTextField.clearButtonMode = .whileEditing
        surnameTextField.clearButtonMode = .whileEditing
        
        [nameTextField, surnameTextField].forEach {
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                $0.heightAnchor.constraint(equalToConstant: viewsHeight)
            ])
        }
        
        let surnameTextFieldTopConstraint = NSLayoutConstraint(
            item: surnameTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: nameTextField,
            attribute: .bottom,
            multiplier: 1,
            constant: 40)
        self.surnameTextFieldTopConstraint = surnameTextFieldTopConstraint
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            surnameTextFieldTopConstraint
        ])
        
        nameTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
        surnameTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
    
    func setupErrorLabels() {
        view.addSubview(nameErrorLabel)
        nameErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(surnameErrorLabel)
        surnameErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nameErrorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            
            surnameErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            surnameErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            surnameErrorLabel.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 10)
        ])
        
        nameErrorLabel.text = "Имя должно содержать больше одного символа."
        nameErrorLabel.numberOfLines = 0
        nameErrorLabel.isHidden = true
        
        surnameErrorLabel.text = "Фамилия должна содержать больше двух символов."
        surnameErrorLabel.numberOfLines = 0
        surnameErrorLabel.isHidden = true
    }
    
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

// MARK: - Continue button callback
private extension NameRegistrationViewController {
    @objc
    func didTapConfirmRegistrationButton() {
        let dateVc = DateRegistrationViewController()
        navigationController?.pushViewController(dateVc, animated: true)
    }
}

// MARK: - Text fields callbacks
private extension NameRegistrationViewController {
    @objc
    func didChangeTextField(_ textField: UITextField) {
        guard let textField = textField as? ShiftCustomTextField else { return }
        switch textField {
        case nameTextField:
            presenter?.didChangeNameTextField(text: textField.text)
        case surnameTextField:
            presenter?.didChangeSurnameTextField(text: textField.text)
        default:
            return
        }
    }
}

// MARK: - Enabling and disabling button
extension NameRegistrationViewController {
    func enableContinueRegistrationButton() {
        guard continueRegistrationButton.buttonState != .normal else { return }
        continueRegistrationButton.buttonState = .normal
    }
    
    func disableContinueRegistrationButton() {
        guard continueRegistrationButton.buttonState != .disabled else { return }
        continueRegistrationButton.buttonState = .disabled
    }
}

// MARK: Showing and hiding error labels
extension NameRegistrationViewController {
    func showNameErrorLabel() {
        surnameTextFieldTopConstraint?.constant = 70
        toggleAppearence(errorLabel: nameErrorLabel, shouldHidden: false)
    }
    
    func hideNameErrorLabel() {
        surnameTextFieldTopConstraint?.constant = 40
        toggleAppearence(errorLabel: nameErrorLabel, shouldHidden: true)
    }
    
    func showSurnameErrorLabel() {
        toggleAppearence(errorLabel: surnameErrorLabel, shouldHidden: false)
    }
    
    func hideSurnameErrorLabel() {
        toggleAppearence(errorLabel: surnameErrorLabel, shouldHidden: true)
    }
    
    private func toggleAppearence(errorLabel: ShiftCustomLabel, shouldHidden: Bool) {
        guard errorLabel.isHidden != !errorLabel.isHidden else { return }
        UIView.animate(withDuration: 0.3) { [weak self, errorLabel] in
            guard let self = self else { return }
            if errorLabel == self.nameErrorLabel {
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
