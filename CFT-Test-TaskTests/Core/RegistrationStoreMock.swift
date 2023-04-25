//
//  RegistrationServiceMock.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import Foundation
import CFT_Test_Task

final class RegistrationStoreMock: RegistrationServiceFullProtocol {
    let name = "Alex"
    let surname = "Bekrenev"
    let birthdate = Date()
    
    var isThereAUserInStore: Bool
    
    var userCredentials: String? {
        return name + " " + surname
    }
    
    func register(name: String, surname: String) {}
    
    func register(birthdate: Date) {}
    
    func confirmRegistration(with password: String) {}
    
    func removeAll() {}
    
    func store(password: String, for user: User) {}
    
    func getPassword(for user: User) -> String? {
        "123456789"
    }
    
    func store(user: User) {}
    
    func getUser() -> User? {
        User(name: name, surname: surname, birthdate: birthdate)
    }
    
    init(isThereAUserInStore: Bool) {
        self.isThereAUserInStore = isThereAUserInStore
    }
}
