//
//  CFT_Test_TaskTests.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 20.04.2023.
//

import XCTest
@testable import CFT_Test_Task

final class GreetingsViewTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        let viewController = GreetingsViewController()
        let presenter = GreetingsViewPresenterSpy()
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testViewControllerGetsRightUserCredentials() {
        let viewController = GreetingsViewControllerSpy()
        let registrationStoreMock = RegistrationStoreMock()
        let presenter = GreetingsViewPresenter(
            registrationService: RegistrationService(registrationStore: registrationStoreMock))

        viewController.presenter = presenter
        presenter.view = viewController

        let expectedCredentials = "\(registrationStoreMock.name) \(registrationStoreMock.surname)"
        
        viewController.viewDidLoad()
        
        let actualCredentials = viewController.recievedCredentials

        XCTAssertEqual(expectedCredentials, actualCredentials)
    }
}
