//
//  ShiftCustomLabel.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import UIKit

final class ShiftCustomLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLabel()
    }
    
    private func setupLabel() {
        font = .systemFont(ofSize: 14)
        textColor = .shiftRed
        textAlignment = .center
    }
}
