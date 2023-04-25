//
//  GreetingsViewControllerSpy.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import Foundation
import CFT_Test_Task

final class GreetingsViewControllerSpy: GreetingsViewControllerProtocol {
    var presenter: GreetingsViewPresenterProtocol?
    var recievedCredentials = ""
    
    func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    func didRecieveGreetings(text: String) {
        self.recievedCredentials = text
    }
}
