//
//  RegistrationService.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import Foundation

protocol RegistrationServiceProtocol {
    var isThereAUserInStore: Bool { get }
    var userCredentials: String? { get }
    func register(name: String, surname: String)
    func register(birthdate: Date)
    func confirmRegistration(with password: String)
    func removeAll()
}

final class RegistrationService: RegistrationServiceProtocol {
    private var user: User = User(name: "", surname: "", birthdate: Date())
    private let registrationStore = RegistrationStore()
    
    static let shared: RegistrationServiceProtocol = RegistrationService()
}

// MARK: - Registration
extension RegistrationService {
    func register(name: String, surname: String) {
        let newUser = User(
            name: name,
            surname: surname,
            birthdate: user.birthdate)
        self.user = newUser
        
        registrationStore.store(user: self.user)
    }
    
    func register(birthdate: Date) {
        let newUser = User(
            name: user.name,
            surname: user.surname,
            birthdate: birthdate)
        self.user = newUser
        
        registrationStore.store(user: self.user)
    }
    
    func confirmRegistration(with password: String) {
        print(user, password)
        registrationStore.store(password: password, for: user)
    }
    
    func removeAll() {
        registrationStore.removeAll()
    }
}

// MARK: - Getting user's info
extension RegistrationService {
    var userCredentials: String? {
        guard let user = registrationStore.getUser() else { return nil }
        let userCredentials = user.name + " " + user.surname
        return userCredentials
    }
    
    var isThereAUserInStore: Bool {
        guard
            let user = registrationStore.getUser(),
            let _ = registrationStore.getPassword(for: user)
        else { return false }
        
        return true
    }
}
