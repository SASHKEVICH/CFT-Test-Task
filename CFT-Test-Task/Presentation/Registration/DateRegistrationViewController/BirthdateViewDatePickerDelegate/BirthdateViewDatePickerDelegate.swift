//
//  BirthdateViewDatePickerDelegate.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 22.04.2023.
//

import UIKit

protocol BirthdateViewDatePickerDelegateProtocol: AnyObject {
    var presenter: DateRegistrationViewPresenterDatePickerProtocol? { get set }
    func didChooseBirthdate(_ datePicker: UIDatePicker)
}

final class BirthdateViewDatePickerDelegate: BirthdateViewDatePickerDelegateProtocol {
    weak var presenter: DateRegistrationViewPresenterDatePickerProtocol?
    
    func didChooseBirthdate(_ datePicker: UIDatePicker) {
        presenter?.didChooseBirthdate(datePicker.date)
    }
}
