//
//  PasswordRegistrationPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 22.04.2023.
//

import Foundation

protocol PasswordRegistrationPresenterProtocol {
    var view: PasswordRegistrationViewControllerProtocol? { get set }
    var textFieldHelper: RegistrationTextFieldHelper? { get }
    func didChangePasswordTextField(text: String?)
    func didChangePasswordConfirmationTextField(text: String?)
    func didTapConfirmRegistrationButton()
}

final class PasswordRegistrationPresenter: PasswordRegistrationPresenterProtocol {
    weak var view: PasswordRegistrationViewControllerProtocol?
    var textFieldHelper: RegistrationTextFieldHelper?
    
    private let registrationService: RegistrationServiceProtocol
    
    private var doesPasswordMatchCondition: Bool = false {
        didSet { considerToEnablingContinueRegistrationButton() }
    }
    
    private var doesPasswordConfirmationMatchCondition: Bool = false {
        didSet { considerToEnablingContinueRegistrationButton() }
    }
    
    private var password: String = ""
    
    init(
        textFieldHelper: RegistrationTextFieldHelper,
        registrationService: RegistrationServiceProtocol
    ) {
        self.registrationService = registrationService
        self.textFieldHelper = textFieldHelper
    }
}

extension PasswordRegistrationPresenter {
    func didChangePasswordTextField(text: String?) {
        guard let view = view, let password = text, password.count != 0 else {
            self.doesPasswordMatchCondition = false
            self.view?.hidePasswordErrorLabel()
            return
        }
        
        guard let regex = try? NSRegularExpression(pattern: "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,16}$")
        else {
            assertionFailure("cannot create regex")
            return
        }
        
        if regex.matches(password) {
            self.doesPasswordMatchCondition = true
            view.hidePasswordErrorLabel()
        } else {
            self.doesPasswordMatchCondition = false
            view.showPasswordErrorLabel()
        }
        
        self.password = password
    }
    
    func didChangePasswordConfirmationTextField(text: String?) {
        guard let view = view, let passwordConfirmation = text, passwordConfirmation.count != 0 else {
            self.doesPasswordConfirmationMatchCondition = false
            self.view?.hidePasswordConfirmationErrorLabel()
            return
        }
        
        if self.password == passwordConfirmation {
            self.doesPasswordConfirmationMatchCondition = true
            self.password = passwordConfirmation
            view.hidePasswordConfirmationErrorLabel()
        } else {
            self.doesPasswordConfirmationMatchCondition = false
            view.showPasswordConfirmationErrorLabel()
        }
    }
    
    func didTapConfirmRegistrationButton() {
        registrationService.confirmRegistration(with: password)
    }
}

private extension PasswordRegistrationPresenter {
    func considerToEnablingContinueRegistrationButton() {
        if doesPasswordMatchCondition && doesPasswordConfirmationMatchCondition {
            view?.enableConfirmRegistrationButton()
        } else {
            view?.disableConfirmRegistrationButton()
        }
    }
}
