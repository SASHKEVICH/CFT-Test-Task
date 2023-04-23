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
}

final class RegistrationService: RegistrationServiceProtocol {
    private var user: User = User(name: "", surname: "", birthdate: Date())
    
    static let shared: RegistrationServiceProtocol = RegistrationService()
    
    func register(name: String, surname: String) {
        let newUser = User(
            name: name,
            surname: surname,
            birthdate: user.birthdate)
        self.user = newUser
        print(user)
    }
    
    func register(birthdate: Date) {
        let newUser = User(
            name: user.name,
            surname: user.surname,
            birthdate: birthdate)
        self.user = newUser
        print(user)
    }
}
