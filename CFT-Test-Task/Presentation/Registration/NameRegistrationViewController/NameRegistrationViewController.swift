//
//  NameRegistrationViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 20.04.2023.
//

import UIKit

final class NameRegistrationViewController: UIViewController {
    private let nameTextField = ShiftCustomTextField()
    private let surnameTextField = ShiftCustomTextField()
    
    private let confirmRegistrationButton = ShiftCustomButton()
    
    private let viewsHeight: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Регистрация"
        navigationController?.navigationBar.tintColor = .shiftRed
        setupRedTopView()
        setupConfirmRegistrationButton()
        setupTextFields()
    }
}

// MARK: - Layout Views
private extension NameRegistrationViewController {
    func setupRedTopView() {
        let redView = UIView()
        redView.backgroundColor = .shiftRed
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            redView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redView.widthAnchor.constraint(equalToConstant: 140),
            redView.heightAnchor.constraint(equalToConstant: 4),
        ])
    }
    
    func setupTextFields() {
        view.addSubview(nameTextField)
        nameTextField.placeholder = "Ваше имя*"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(surnameTextField)
        surnameTextField.placeholder = "Ваша фамилия*"
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [nameTextField, surnameTextField].forEach {
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                $0.heightAnchor.constraint(equalToConstant: viewsHeight)
            ])
        }
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
        ])
    }
    
    func setupConfirmRegistrationButton() {
        view.addSubview(confirmRegistrationButton)
        confirmRegistrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            confirmRegistrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmRegistrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmRegistrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            confirmRegistrationButton.heightAnchor.constraint(equalToConstant: viewsHeight)
        ])
        
        confirmRegistrationButton.title = "Продолжить"
        confirmRegistrationButton.buttonState = .normal
        confirmRegistrationButton.addTarget(self, action: #selector(didTapConfirmRegistrationButton), for: .touchUpInside)
    }
}

private extension NameRegistrationViewController {
    @objc
    func didTapConfirmRegistrationButton() {
        print("tap")
        let dateVc = DateRegistrationViewController()
        navigationController?.pushViewController(dateVc, animated: true)
    }
}
