//
//  NewsTableViewCell.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    static let identifier = String(describing: NewsTableViewCell.self)
    
    private let cellContentView = UIView()
    private let cellTitleLabel = UILabel()
    private let additionalInfoLabel = UILabel()
    private let selectBackgroundView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var cellTitle: String? {
        didSet {
            cellTitleLabel.text = cellTitle
            cellTitleLabel.sizeToFit()
        }
    }
    
    var additionalInfo: String? {
        didSet {
            additionalInfoLabel.text = additionalInfo
            additionalInfoLabel.isHidden = false
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellTitleLabel()
        setupAdditionalInfoLabel()
        setupDefaultCellBackground()
        
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
}

// MARK: - Setup Cell depending on its position
extension NewsTableViewCell {
    func setupFirstCellInTableView() -> NewsTableViewCell {
        selectBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        selectBackgroundView.layer.cornerRadius = 16
        selectBackgroundView.layer.masksToBounds = true
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 16
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return self
    }
    
    func setupLastCellWithoutBottomSeparator(
        tableViewWidth: CGFloat
    ) -> NewsTableViewCell {
        selectBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        selectBackgroundView.layer.cornerRadius = 16
        selectBackgroundView.layer.masksToBounds = true
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 16
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.separatorInset = UIEdgeInsets(
            top: 0,
            left: tableViewWidth + 1,
            bottom: 0,
            right: 0)
        return self
    }
    
    private func resetCell() {
        cellTitleLabel.text = ""
        additionalInfoLabel.text = ""
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0
    }
}

// MARK: Setup Views
private extension NewsTableViewCell {
    func setupCellTitleLabel() {
        contentView.addSubview(cellTitleLabel)
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
        
        cellTitleLabel.textColor = .black
        cellTitleLabel.numberOfLines = 0
        cellTitleLabel.font = .systemFont(ofSize: 15)
    }
    
    func setupAdditionalInfoLabel() {
        contentView.addSubview(additionalInfoLabel)
        additionalInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            additionalInfoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            additionalInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            additionalInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            additionalInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        additionalInfoLabel.font = .systemFont(ofSize: 14)
        additionalInfoLabel.textColor = .gray
    }
    
    func setupDefaultCellBackground() {
        backgroundColor = .shiftCellBackground
        selectedBackgroundView = selectBackgroundView
    }
}
