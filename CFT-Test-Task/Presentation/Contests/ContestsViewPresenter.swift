//
//  ContestsViewPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

protocol ContestsViewPresenterProtocol {
    var view: ContestsViewControllerProtocol? { get set }
    func viewDidLoad()
}

final class ContestsViewPresenter: ContestsViewPresenterProtocol {
    weak var view: ContestsViewControllerProtocol?
    
    func viewDidLoad() {
        print(#function)
    }
}
