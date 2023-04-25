//
//  NameRegistrationViewPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import Foundation

protocol NameRegistrationViewPresenterProtocol {
    var view: NameRegistrationViewControllerProtocol? { get set }
    var textFieldHelper: RegistrationTextFieldHelperProtocol? { get }
    func didChangeNameTextField(text: String?)
    func didChangeSurnameTextField(text: String?)
    func didTapContinueRegistrationButton()
}

final class NameRegistrationViewPresenter: NameRegistrationViewPresenterProtocol {
    weak var view: NameRegistrationViewControllerProtocol?
    
    private let registrationService: RegistrationServiceProtocol
    
    private var doesNameMatchCondition: Bool = false {
        didSet { considerToEnablingContinueRegistrationButton() }
    }
    
    private var doesSurnameMatchCondition: Bool = false {
        didSet { considerToEnablingContinueRegistrationButton() }
    }
    
    private var name: String = ""
    private var surname: String = ""
    
    var textFieldHelper: RegistrationTextFieldHelperProtocol?
    
    init(
        textFieldHelper: RegistrationTextFieldHelperProtocol,
        registrationService: RegistrationServiceProtocol
    ) {
        self.textFieldHelper = textFieldHelper
        self.registrationService = registrationService
    }
}

// MARK: - NameRegistrationViewPresenterProtocol
extension NameRegistrationViewPresenter {
    func didChangeNameTextField(text: String?) {
        guard let view = view, let name = text, name.count != 0 else {
            self.doesNameMatchCondition = false
            self.view?.hideNameErrorLabel()
            return
        }
        
        if name.count <= 1 {
            self.doesNameMatchCondition = false
            view.showNameErrorLabel()
        } else {
            self.doesNameMatchCondition = true
            self.name = name
            view.hideNameErrorLabel()
        }
    }
    
    func didChangeSurnameTextField(text: String?) {
        guard let view = view, let surname = text, surname.count != 0 else {
            self.doesSurnameMatchCondition = false
            self.view?.hideSurnameErrorLabel()
            return
        }
        
        if surname.count <= 2 {
            self.doesSurnameMatchCondition = false
            view.showSurnameErrorLabel()
        } else {
            self.doesSurnameMatchCondition = true
            self.surname = surname
            view.hideSurnameErrorLabel()
        }
    }
    
    func didTapContinueRegistrationButton() {
        registrationService.register(name: name, surname: surname)
    }
}

private extension NameRegistrationViewPresenter {
    func considerToEnablingContinueRegistrationButton() {
        if doesNameMatchCondition && doesSurnameMatchCondition {
            view?.enableContinueRegistrationButton()
        } else {
            view?.disableContinueRegistrationButton()
        }
    }
}
