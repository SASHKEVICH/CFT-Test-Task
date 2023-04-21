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
    
    private var isNameErrorLabelHidden: Bool = true {
        didSet { considerToDisablingContinueRegistrationButton() }
    }
    
    private var isSurnameErrorLabelHidden: Bool = true {
        didSet { considerToDisablingContinueRegistrationButton() }
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
        guard let view = view, let text = text, text.count != 0 else { return }
        
        if text.count <= 1 {
            isNameErrorLabelHidden = view.showNameErrorLabel()
        } else {
            isNameErrorLabelHidden = view.hideNameErrorLabel()
        }
    }
    
    func didChangeSurnameTextField(text: String?) {
        guard let view = view, let text = text, text.count != 0 else { return }
        
        if text.count <= 2 {
            isSurnameErrorLabelHidden = view.showSurnameErrorLabel()
        } else {
            isSurnameErrorLabelHidden = view.hideSurnameErrorLabel()
        }
    }
    
    private func considerToDisablingContinueRegistrationButton() {
        if isNameErrorLabelHidden && isSurnameErrorLabelHidden {
            view?.enableContinueRegistrationButton()
        } else {
            view?.disableContinueRegistrationButton()
        }
    }
}
