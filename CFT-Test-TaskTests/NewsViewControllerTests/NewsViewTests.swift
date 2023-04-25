//
//  NewsViewTests.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import XCTest
@testable import CFT_Test_Task

final class NewsViewTests: XCTestCase {
    func testViewControllerCallsRequestNews() {
        let viewController = NewsViewController()
        let presenter = NewsViewPresenterSpy()
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.requestNewsCalled)
    }
    
    func testPresenterCalledDidUpdatePhotosAnimated() {
        let viewController = NewsViewControllerSpy()
        
        let newsService = NewsServiceMock()
        let presenter = NewsViewPresenter(
            tableViewHelper: NewsTableViewHelperDummy(),
            newsService: newsService,
            registrationService: RegistrationServiceMock())
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        presenter.requestNews()
        
        XCTAssertTrue(viewController.updateNewsAnimatedCalled)
    }
}
