//
//  GreetingsViewPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 25.04.2023.
//

import Foundation

protocol GreetingsViewPresenterProtocol {
    var view: GreetingsViewControllerProtocol? { get set }
    func viewDidLoad()
}

final class GreetingsViewPresenter: GreetingsViewPresenterProtocol {
    private let registrationService: RegistrationServiceProtocol
    
    weak var view: GreetingsViewControllerProtocol?
    
    func viewDidLoad() {
        guard let credentials = registrationService.userCredentials else { return }
        view?.didRecieveGreetings(text: credentials)
    }
    
    init(registrationService: RegistrationServiceProtocol) {
        self.registrationService = registrationService
    }
}
