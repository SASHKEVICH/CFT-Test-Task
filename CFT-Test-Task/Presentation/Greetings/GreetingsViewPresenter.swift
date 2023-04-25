//
//  GreetingsViewPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 25.04.2023.
//

import Foundation

public protocol GreetingsViewPresenterProtocol {
    var view: GreetingsViewControllerProtocol? { get set }
    func viewDidLoad()
}

final class GreetingsViewPresenter: GreetingsViewPresenterProtocol {
    private let registrationService: RegistrationServiceCredentialsProtocol
    
    weak var view: GreetingsViewControllerProtocol?
    
    init(registrationService: RegistrationServiceCredentialsProtocol) {
        self.registrationService = registrationService
    }
}

extension GreetingsViewPresenter {
    func viewDidLoad() {
        guard let credentials = registrationService.userCredentials else { return }
        view?.didRecieveGreetings(text: credentials)
    }
}
