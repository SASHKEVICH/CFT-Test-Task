//
//  SceneDelegate.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 20.04.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let nameRegistrationViewController = NameRegistrationViewController()
        let nameRegistrationPresenter = NameRegistrationPresenter(
            textFieldHelper: RegistrationTextFieldHelper(),
            registrationService: RegistrationService.shared)
        
        nameRegistrationPresenter.view = nameRegistrationViewController
        nameRegistrationViewController.presenter = nameRegistrationPresenter
        
        let navigationController = UINavigationController(
            rootViewController: nameRegistrationViewController)
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .shiftRed
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

