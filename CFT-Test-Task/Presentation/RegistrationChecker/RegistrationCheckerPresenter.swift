//
//  RegistrationCheckerPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

protocol RegistrationCheckerPresenterProtocol {
    var view: RegistrationCheckerViewControllerProtocol? { get set }
    func viewDidAppear()
}

final class RegistrationCheckerPresenter: RegistrationCheckerPresenterProtocol {
    weak var view: RegistrationCheckerViewControllerProtocol?
    
    private var registrationService: RegistrationServiceProtocol
    
    init(registrationService: RegistrationServiceProtocol) {
        self.registrationService = registrationService
    }
    
    func viewDidAppear() {
        if registrationService.isThereAUserInStore {
            view?.switchToContestsViewController()
        } else {
            view?.switchToRegistrationViewController()
        }
    }
}
