//
//  RegistrationService.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import Foundation

protocol RegistrationServiceProtocol {
    func register(name: String, surname: String)
    func register(birthdate: Date)
    func confirmRegistration(with password: String)
}

final class RegistrationService: RegistrationServiceProtocol {
    private var user: User = User(name: "", surname: "", birthdate: Date())
    private let registrationStore = RegistrationStore()
    
    static let shared: RegistrationServiceProtocol = RegistrationService()
    
    func register(name: String, surname: String) {
        let newUser = User(
            name: name,
            surname: surname,
            birthdate: user.birthdate)
        self.user = newUser
        
        registrationStore.store(user: self.user)
        print(registrationStore.getUser())
    }
    
    func register(birthdate: Date) {
        let newUser = User(
            name: user.name,
            surname: user.surname,
            birthdate: birthdate)
        self.user = newUser
        
        registrationStore.store(user: self.user)
        print(registrationStore.getUser())
    }
    
    func confirmRegistration(with password: String) {
        print(user, password)
        registrationStore.store(password: password, for: user)
    }
}
