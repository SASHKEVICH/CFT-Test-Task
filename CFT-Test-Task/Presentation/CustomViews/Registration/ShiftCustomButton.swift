//
//  ShiftCustomButton.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import UIKit

enum ShiftCustomButtonState {
    case normal
    case disabled
}

final class ShiftCustomButton: UIButton {
    var title: String?
    var buttonState: ShiftCustomButtonState? {
        didSet {
            setNeededButtonState()
        }
    }
   
    override func draw(_ rect: CGRect) {
       super.draw(rect)
       layer.cornerRadius = 3
       layer.masksToBounds = true
       
       setNeededButtonState()
    }
}

private extension ShiftCustomButton {
    func setNeededButtonState() {
        guard let buttonState = buttonState else {
            assertionFailure("Button state in nil")
            return
        }
        
        switch buttonState {
        case .normal:
            setNormalState()
        case .disabled:
            setDisabledState()
        }
    }
    
    func setNormalState() {
        self.isEnabled = true
        layer.backgroundColor = UIColor.shiftRed?.cgColor
        
        setAttributedButtonTitle()
        setTitleColor(.white, for: .normal)
    }
    
    func setDisabledState() {
        self.isEnabled = false
        layer.backgroundColor = UIColor.shiftGray?.cgColor
        
        setAttributedButtonTitle()
        setTitleColor(.white, for: .normal)
    }
    
    func setAttributedButtonTitle() {
        guard let title = title else {
            assertionFailure("Title is nil")
            return
        }
        
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: font])
        setAttributedTitle(attributedTitle, for: .normal)
    }
}

