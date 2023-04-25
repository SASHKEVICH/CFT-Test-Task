//
//  NewsViewControllerSpy.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import Foundation
import CFT_Test_Task

final class NewsViewControllerSpy: NewsViewControllerProtocol {
    var presenter: CFT_Test_Task.NewsViewPresenterProtocol?
    var updateNewsAnimatedCalled: Bool = false
    
    func didUpdateNewsAnimated(newsCount: Int, batchAmount: Int) {
        self.updateNewsAnimatedCalled = true
    }
    
    func showActivityIndicator() {}
    
    func hideActivityIndicator() {}
    
    func showNewsInSafari(with url: URL) {}
    
    func showGreetings() {}
}
