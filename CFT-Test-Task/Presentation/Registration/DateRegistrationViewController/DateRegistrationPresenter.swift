//
//  DateRegistrationPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 22.04.2023.
//

import Foundation

protocol DateRegistrationPresenterDatePickerProtocol: AnyObject {
    func didChooseBirthdate(_ birthdate: Date)
}

protocol DateRegistrationPresenterProtocol {
    var view: DateRegistrationViewControllerProtocol? { get set }
    var datePickerDelegate: BirthdateViewDatePickerDelegateProtocol? { get set }
    var chosenBirthdate: Date? { get }
    func didTapContinueRegistrationButton()
}

final class DateRegistrationPresenter: DateRegistrationPresenterProtocol {
    weak var view: DateRegistrationViewControllerProtocol?
    
    private let registrationService: RegistrationServiceProtocol
    
    var chosenBirthdate: Date?
    var datePickerDelegate: BirthdateViewDatePickerDelegateProtocol?
    
    init(
        datePickerDelegate: BirthdateViewDatePickerDelegateProtocol,
        registrationService: RegistrationServiceProtocol
    ) {
        self.registrationService = registrationService
        setupDatePickerDelegate(datePickerDelegate)
    }
}

extension DateRegistrationPresenter: DateRegistrationPresenterDatePickerProtocol {
    func didChooseBirthdate(_ birthdate: Date) {
        validate(birthdate: birthdate)
    }
    
    func didTapContinueRegistrationButton() {
        guard let chosenBirthdate = chosenBirthdate else { return }
        registrationService.register(birthdate: chosenBirthdate)
    }
}

private extension DateRegistrationPresenter {
    func setupDatePickerDelegate(_ datePickerDelegate: BirthdateViewDatePickerDelegateProtocol) {
        self.datePickerDelegate = datePickerDelegate
        datePickerDelegate.presenter = self
    }
    
    func validate(birthdate: Date) {
        let currentDate = Date()
        guard birthdate <= currentDate else {
            view?.showBirthdateErrorLabel()
            view?.disableContinueRegistrationButton()
            return
        }
        
        view?.hideBirthdateErrorLabel()
        view?.enableContinueRegistrationButton()
        self.chosenBirthdate = birthdate
    }
}
