//
//  RegistrationServiceTests.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import XCTest
@testable import CFT_Test_Task

final class RegistrationServiceTests: XCTestCase {
    func testRegistrationServiceRegisterUserCredentials() {
        let registrationStoreMock = RegistrationStoreMock()
        let registrationService = RegistrationService(registrationStore: registrationStoreMock)
        
        guard let user = registrationStoreMock.user else {
            XCTFail()
            return
        }
        
        registrationService.register(name: user.name, surname: user.surname)
        
        let expectedUserCredentials = user.name + " " + user.surname
        let actualUserCredentials = registrationService.userCredentials
        
        XCTAssertTrue(registrationService.isThereAUserInStore)
        XCTAssertTrue(actualUserCredentials == expectedUserCredentials)
    }
    
    func testRegistrationServiceRegisterBirthdate() {
        let registrationStoreMock = RegistrationStoreMock()
        let registrationService = RegistrationService(registrationStore: registrationStoreMock)
        
        guard let user = registrationStoreMock.user else {
            XCTFail()
            return
        }
        
        registrationService.register(birthdate: user.birthdate)
        
        let expectedUserBirthdate = user.birthdate
        let actualUserBirthdate = registrationStoreMock.user?.birthdate
        
        XCTAssertTrue(registrationService.isThereAUserInStore)
        XCTAssertTrue(expectedUserBirthdate == actualUserBirthdate)
    }
    
    func testRegistrationServiceRegisterPassword() {
        let registrationStoreMock = RegistrationStoreMock()
        let registrationService = RegistrationService(registrationStore: registrationStoreMock)
        
        let expectedPassword = "oi9j09345"
        registrationService.confirmRegistration(with: expectedPassword)
        
        let actualPassword = registrationStoreMock.password
        
        XCTAssertTrue(registrationService.isThereAUserInStore)
        XCTAssertTrue(expectedPassword == actualPassword)
    }
    
    func testRegistrationServiceRemoveAllUserInfo() {
        let registrationStoreMock = RegistrationStoreMock()
        let registrationService = RegistrationService(registrationStore: registrationStoreMock)

        registrationService.removeAll()
        
        XCTAssertFalse(registrationService.isThereAUserInStore)
        XCTAssertNil(registrationStoreMock.user)
    }
}
