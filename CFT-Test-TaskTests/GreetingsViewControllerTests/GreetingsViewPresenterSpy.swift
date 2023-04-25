//
//  GreetingsViewPresenterSpy.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import Foundation
import CFT_Test_Task

final class GreetingsViewPresenterSpy: GreetingsViewPresenterProtocol {
    weak var view: GreetingsViewControllerProtocol?
    var viewDidLoadCalled = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
}
