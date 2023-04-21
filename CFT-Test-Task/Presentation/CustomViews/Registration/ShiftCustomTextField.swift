//
//  ShiftCustomTextField.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 20.04.2023.
//

import UIKit

final class ShiftCustomTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupTextField()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}

private extension ShiftCustomTextField {
    func setupTextField() {
        textColor = .black
        backgroundColor = .white
        
        setupBorder()
        setupPlaceholder()
    }
    
    func setupBorder() {
        layer.cornerRadius = 3
        layer.masksToBounds = true
        layer.borderColor = UIColor.shiftLightGray?.cgColor
        layer.borderWidth = 1
    }
    
    func setupPlaceholder() {
        font = .systemFont(ofSize: 16)
        
        if let placeholder = placeholder, let grayColor = UIColor.shiftGray {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: grayColor])
        }
    }
}
