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
        
        let registrationCheckerPresenter = RegistrationCheckerPresenter(registrationService: RegistrationService.shared)
        let registrationCheckerViewController = RegistrationCheckerViewController()
        
        registrationCheckerPresenter.view = registrationCheckerViewController
        registrationCheckerViewController.presenter = registrationCheckerPresenter
        
        window.rootViewController = registrationCheckerViewController
        window.makeKeyAndVisible()
    }
}

