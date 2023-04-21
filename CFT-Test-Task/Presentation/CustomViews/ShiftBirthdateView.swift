//
//  ShiftBirthdateView.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 20.04.2023.
//

import UIKit

final class ShiftBirthdateView: UIView {
    private let textLabel = UILabel()
    private let datePicker = UIDatePicker()
    
    var text: String? {
        didSet {
            textLabel.text = text
            textLabel.sizeToFit()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        backgroundColor = .white
        
        setupBorder()
        setupTextLabel()
        setupDatePicker()
    }
}

private extension ShiftBirthdateView {
    func setupBorder() {
        layer.cornerRadius = 3
        layer.masksToBounds = true
        layer.borderColor = UIColor.shiftLightGray?.cgColor
        layer.borderWidth = 1
    }
    
    func setupTextLabel() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        textLabel.font = .systemFont(ofSize: 16)
        textLabel.textColor = .shiftGray
        textLabel.text = "Ваша дата рождения*"
    }
    
    func setupDatePicker() {
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            datePicker.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.datePickerMode = .date
        datePicker.tintColor = .shiftRed
    }
}
