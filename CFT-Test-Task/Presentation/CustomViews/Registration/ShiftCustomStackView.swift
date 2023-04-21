//
//  ShiftCustomStackView.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 21.04.2023.
//

import UIKit

final class ShiftCustomStackView: UIStackView {
    var redViewsCount: Int?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupStackView()
        setupRedViews()
    }
}

private extension ShiftCustomStackView {
    func setupStackView() {
        axis = .horizontal
        spacing = 10
        distribution = .fillEqually
    }
    
    func setupRedViews() {
        guard let redViewsCount = redViewsCount, arrangedSubviews.isEmpty else { return }
        for _ in 0..<redViewsCount {
            let redView = UIView()
            redView.backgroundColor = .shiftRed
            redView.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(redView)
            
            NSLayoutConstraint.activate([
                redView.topAnchor.constraint(equalTo: topAnchor),
                redView.heightAnchor.constraint(equalToConstant: 4),
            ])
        }
    }
}
