//
//  RegistrationServiceMock.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import Foundation
import CFT_Test_Task

final class RegistrationServiceMock: RegistrationServiceFullProtocol {
    func removeAll() {
        
    }
    
    var isThereAUserInStore: Bool = true
    
    var userCredentials: String?
    
    func register(name: String, surname: String) {
        
    }
    
    func register(birthdate: Date) {
        
    }
    
    func confirmRegistration(with password: String) {
        
    }
}
