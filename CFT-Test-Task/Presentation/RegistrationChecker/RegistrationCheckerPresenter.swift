//
//  RegistrationCheckerPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

protocol RegistrationCheckerPresenterProtocol {
    var view: RegistrationCheckerViewControllerProtocol? { get set }
    func viewDidAppear()
    func getNameRegistrationViewController() -> NameRegistrationViewController
    func getContestsViewController() -> NewsViewController
}

final class RegistrationCheckerPresenter: RegistrationCheckerPresenterProtocol {
    weak var view: RegistrationCheckerViewControllerProtocol?
    
    private var registrationService: RegistrationServiceCredentialsProtocol
    
    init(registrationService: RegistrationServiceCredentialsProtocol) {
        self.registrationService = registrationService
    }
}

// MARK: - RegistrationCheckerPresenterProtocol
extension RegistrationCheckerPresenter {
    func viewDidAppear() {
        if registrationService.isThereAUserInStore {
            view?.switchToContestsViewController()
        } else {
            view?.switchToRegistrationViewController()
        }
    }
    
    func getNameRegistrationViewController() -> NameRegistrationViewController {
        let nameRegistrationViewController = NameRegistrationViewController()
        let nameRegistrationPresenter = NameRegistrationViewPresenter(
            textFieldHelper: RegistrationTextFieldHelper(),
            registrationService: RegistrationService.shared)
        
        nameRegistrationPresenter.view = nameRegistrationViewController
        nameRegistrationViewController.presenter = nameRegistrationPresenter
        
        return nameRegistrationViewController
    }
    
    func getContestsViewController() -> NewsViewController {
        let newsViewController = NewsViewController()
        
        let newsTableViewHelper = NewsTableViewHelper()
        let newsService = NewsService()
        let newsViewPresenter = NewsViewPresenter(
            tableViewHelper: newsTableViewHelper,
            newsService: newsService,
            registrationService: RegistrationService.shared)
        
        newsViewController.presenter = newsViewPresenter
        newsViewPresenter.view = newsViewController
        
        return newsViewController
    }
}
