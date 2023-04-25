//
//  User.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

public struct User: Codable {
    let name: String
    let surname: String
    let birthdate: Date
    
    public init(name: String, surname: String, birthdate: Date) {
        self.name = name
        self.surname = surname
        self.birthdate = birthdate
    }
}
