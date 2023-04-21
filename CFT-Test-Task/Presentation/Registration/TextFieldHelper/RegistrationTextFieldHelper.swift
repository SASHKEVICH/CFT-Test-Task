//
//  RegistrationTextFieldHelper.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import UIKit

protocol RegistrationTextFieldHelperProtocol: UITextFieldDelegate {}

final class RegistrationTextFieldHelper: NSObject, RegistrationTextFieldHelperProtocol {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
}
