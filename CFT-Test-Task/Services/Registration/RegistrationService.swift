//
//  RegistrationService.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import Foundation

public protocol RegistrationServiceAllRemoveProtocol {
    func removeAll()
}

public protocol RegistrationServiceCredentialsProtocol {
    var isThereAUserInStore: Bool { get }
    var userCredentials: String? { get }
}

public protocol RegistrationServiceProtocol {
    func register(name: String, surname: String)
    func register(birthdate: Date)
    func confirmRegistration(with password: String)
}

public typealias RegistrationServiceFullProtocol =
    RegistrationServiceAllRemoveProtocol
    & RegistrationServiceCredentialsProtocol
    & RegistrationServiceProtocol

final class RegistrationService {
    private var user: User = User(name: "", surname: "", birthdate: Date())
    private let registrationStore: RegistrationStoreProtocol
    
    static let shared: RegistrationServiceFullProtocol = RegistrationService()
    
    init(registrationStore: RegistrationStoreProtocol) {
        self.registrationStore = registrationStore
    }
    
    init() {
        self.registrationStore = RegistrationStore()
    }
}

// MARK: - RegistrationServiceProtocol
extension RegistrationService: RegistrationServiceProtocol {
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
        registrationStore.store(password: password, for: user)
    }
}

// MARK: - RegistrationServiceAllRemoveProtocol
extension RegistrationService: RegistrationServiceAllRemoveProtocol {
    func removeAll() {
        registrationStore.removeAll()
    }
}

// MARK: - RegistrationServiceCredentialsProtocol
extension RegistrationService: RegistrationServiceCredentialsProtocol {
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
