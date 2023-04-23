//
//  RegistrationStore.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

struct RegistrationStore {
    private let userDefaults = UserDefaults.standard
    private let keychainWrapper = KeychainWrapper()
    
    private let userKey = "userKey"
}

// MARK: - Working with user
extension RegistrationStore {
    func store(user: User) {
        guard let data = try? JSONEncoder().encode(user) else {
            assertionFailure("cannot encode user")
            return
        }
        
        userDefaults.set(data, forKey: userKey)
    }
    
    func getUser() -> User? {
        guard
            let data = userDefaults.data(forKey: userKey),
            let user = try? JSONDecoder().decode(User.self, from: data)
        else { return nil }
        
        return user
    }
    
    func removeUser() {
        userDefaults.removeObject(forKey: userKey)
    }
}

// MARK: - Working with password
extension RegistrationStore {
    func store(password: String, for user: User) {
        let userCredentials = user.name + user.surname
        
        do {
            try keychainWrapper.store(password: password, for: userCredentials)
        } catch {
            assertionFailure("\(error)")
        }
    }
    
    func getPassword(for user: User) -> String? {
        let userCredentials = user.name + user.surname
        
        do {
            let password = try keychainWrapper.getPassword(for: userCredentials)
            return password
        } catch {
            assertionFailure("\(error)")
            return nil
        }
    }
}

// MARK: - Removing info from user defaults and keychain
extension RegistrationStore {
    func removeAll() {
        do {
            try keychainWrapper.removeAll()
            removeUser()
        } catch {
            print(error)
        }
    }
}
