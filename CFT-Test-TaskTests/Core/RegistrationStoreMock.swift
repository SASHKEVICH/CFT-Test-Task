//
//  RegistrationServiceMock.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import Foundation
import CFT_Test_Task

final class RegistrationStoreMock: RegistrationStoreProtocol {
    let name = "Alex"
    let surname = "Bekrenev"
    let birthdate = Date()
    var user: User?
    
    var password = ""
    
    func removeAll() {}
    
    func store(password: String, for user: User) {
        self.password = password
    }
    
    func getPassword(for user: User) -> String? {
        password
    }
    
    func store(user: User) {
        self.user = user
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    init() {
        self.user = User(name: name, surname: surname, birthdate: birthdate)
    }
}
