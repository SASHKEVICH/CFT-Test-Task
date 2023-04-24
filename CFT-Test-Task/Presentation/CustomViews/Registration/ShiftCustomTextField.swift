//
//  ShiftCustomTextField.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 20.04.2023.
//

import UIKit

final class ShiftCustomTextField: UITextField {
    enum ShiftCustomTextFieldType {
        case password
        case normal
    }
    
    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    private let rightViewPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    
    var type: ShiftCustomTextFieldType = .normal {
        didSet {
            setupNeededTextFieldType()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupTextField()
        setupNeededTextFieldType()
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
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: bounds.width - 46, y: bounds.height / 2 - 15, width: 30, height: 30)
    }
}

private extension ShiftCustomTextField {
    func setupNeededTextFieldType() {
        guard type != .normal else { return }
        setupSecureTextField()
    }
    
    func setupTextField() {
        textColor = .black
        backgroundColor = .white
        
        setupBorder()
        setupPlaceholder()
    }
    
    func setupSecureTextField() {
        isSecureTextEntry = true
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .shiftRed
        
        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
        
        rightView = button
        rightViewMode = .always
    }
    
    @objc
    func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
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
