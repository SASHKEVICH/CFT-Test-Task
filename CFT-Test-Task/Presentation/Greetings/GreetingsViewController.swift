//
//  GreetingsViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 25.04.2023.
//

import UIKit

public protocol GreetingsViewControllerProtocol: AnyObject {
    var presenter: GreetingsViewPresenterProtocol? { get set }
    func didRecieveGreetings(text: String)
}

final class GreetingsViewController: UIViewController, GreetingsViewControllerProtocol {
    private let greetingsLabel = UILabel()
    
    var presenter: GreetingsViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupGreetingsLabel()
        presenter?.viewDidLoad()
    }
}

extension GreetingsViewController {
    func didRecieveGreetings(text: String) {
        greetingsLabel.text = "Здравствуйте, \(text)!"
    }
}

// MARK: - Private methods
private extension GreetingsViewController {
    func setupGreetingsLabel() {
        view.addSubview(greetingsLabel)
        greetingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greetingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            greetingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            greetingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
        
        greetingsLabel.font = .systemFont(ofSize: 25, weight: .medium)
        greetingsLabel.textAlignment = .center
        greetingsLabel.numberOfLines = 0
    }
}
