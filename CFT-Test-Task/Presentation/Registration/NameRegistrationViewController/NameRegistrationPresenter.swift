//
//  NameRegistrationPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import Foundation

protocol NameRegistrationPresenterProtocol {
    var view: NameRegistrationViewControllerProtocol? { get set }
    var textFieldHelper: RegistrationTextFieldHelperProtocol? { get }
    func didChangeNameTextField(text: String?)
    func didChangeSurnameTextField(text: String?)
}

final class NameRegistrationPresenter: NameRegistrationPresenterProtocol {
    weak var view: NameRegistrationViewControllerProtocol?
    
    var textFieldHelper: RegistrationTextFieldHelperProtocol?
    
    private var doesNameMatchCondition: Bool = false {
        didSet { considerToEnablingContinueRegistrationButton() }
    }
    private var doesSurnameMatchCondition: Bool = false {
        didSet { considerToEnablingContinueRegistrationButton() }
    }
    
    init() {
        setupTextFieldHelper()
    }
}

private extension NameRegistrationPresenter {
    func setupTextFieldHelper() {
        let textFieldHelper = RegistrationTextFieldHelper()
        self.textFieldHelper = textFieldHelper
    }
}

extension NameRegistrationPresenter {
    func didChangeNameTextField(text: String?) {
        guard let view = view, let text = text, text.count != 0 else {
            self.doesNameMatchCondition = false
            return
        }
        
        if text.count <= 1 {
            self.doesNameMatchCondition = false
            view.showNameErrorLabel()
        } else {
            self.doesNameMatchCondition = true
            view.hideNameErrorLabel()
        }
    }
    
    func didChangeSurnameTextField(text: String?) {
        guard let view = view, let text = text, text.count != 0 else {
            self.doesSurnameMatchCondition = false
            return
        }
        
        if text.count <= 2 {
            self.doesSurnameMatchCondition = false
            view.showSurnameErrorLabel()
        } else {
            self.doesSurnameMatchCondition = true
            view.hideSurnameErrorLabel()
        }
    }
    
    private func considerToEnablingContinueRegistrationButton() {
        if doesNameMatchCondition && doesSurnameMatchCondition {
            view?.enableContinueRegistrationButton()
        } else {
            view?.disableContinueRegistrationButton()
        }
    }
}
