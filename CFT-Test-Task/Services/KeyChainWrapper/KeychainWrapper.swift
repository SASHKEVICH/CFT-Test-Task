//
//  KeychainWrapper.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

enum KeychainWrapperError: Error {
    case cannotStorePassword
    case cannotUpdatePassword
    case cannotGetPassword
    case passwordConversionError
    case unhandledError(message: String)
}

struct KeychainWrapper {
    private func error(from status: OSStatus) -> KeychainWrapperError {
        let message = SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
        return KeychainWrapperError.unhandledError(message: message)
    }
}

// MARK: Storing password
extension KeychainWrapper {
    func store(password: String, for attribute: String) throws {
        guard let encodedPassword = password.data(using: .utf8) else {
            throw KeychainWrapperError.passwordConversionError
        }
        
        var storeQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                         kSecAttrAccount as String: attribute]

        var status = SecItemCopyMatching(storeQuery as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[String(kSecValueData)] = encodedPassword

            status = SecItemUpdate(
                storeQuery as CFDictionary,
                attributesToUpdate as CFDictionary)
            
            if status != errSecSuccess {
                throw KeychainWrapperError.cannotUpdatePassword
            }
        case errSecItemNotFound:
            storeQuery[String(kSecValueData)] = encodedPassword

            status = SecItemAdd(storeQuery as CFDictionary, nil)
            
            if status != errSecSuccess {
                throw KeychainWrapperError.cannotStorePassword
            }
        default:
            throw error(from: status)
        }
    }
}

// MARK: - Getting password
extension KeychainWrapper {
    func getPassword(for attribute: String) throws -> String? {
        let getQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                       kSecMatchLimit as String: kSecMatchLimitOne,
                                       kSecAttrAccount as String: attribute,
                                       kSecReturnAttributes as String: true,
                                       kSecReturnData as String: true]

        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(getQuery as CFDictionary, $0)
        }
        
        switch status {
        case errSecSuccess:
            guard
                let queriedItem = queryResult as? [String: Any],
                let passwordData = queriedItem[String(kSecValueData)] as? Data,
                let password = String(data: passwordData, encoding: .utf8)
            else { throw KeychainWrapperError.passwordConversionError }
            
            return password
        case errSecItemNotFound:
            return nil
        default:
            throw error(from: status)
        }
    }
}

// MARK: - Removing password from keychain
extension KeychainWrapper {
    func removeAll() throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }
}
