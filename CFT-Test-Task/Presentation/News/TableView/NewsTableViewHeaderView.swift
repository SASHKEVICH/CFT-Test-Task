//
//  NewsTableViewHeaderView.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 24.04.2023.
//

import UIKit

final class NewsTableViewHeaderView: UITableViewHeaderFooterView {
    static let identifier = String(describing: NewsTableViewHeaderView.self)
    
    private let greetingsButton = ShiftCustomButton()
    
    var delegate: NewsTableViewHeaderViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        setupGreetingsButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Setup Greeting button
private extension NewsTableViewHeaderView {
    func setupGreetingsButton() {
        contentView.addSubview(greetingsButton)
        greetingsButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            greetingsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            greetingsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            greetingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            greetingsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
        
        greetingsButton.title = "Поприветствовать"
        greetingsButton.buttonState = .normal
        greetingsButton.addTarget(self, action: #selector(didTapGreetingsButton), for: .touchUpInside)
    }
    
    @objc
    func didTapGreetingsButton() {
        delegate?.didTapGreetingsButton()
    }
}
