//
//  NewsViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import UIKit

protocol NewsViewControllerProtocol: AnyObject {
    var presenter: NewsViewPresenterProtocol? { get set }
}

final class NewsViewController: UIViewController, NewsViewControllerProtocol {
    private let newsTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var presenter: NewsViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Новости"
        presenter?.viewDidLoad()
        
        setupNewsTableView()
        
        newsTableView.reloadData()
    }
}

private extension NewsViewController {
    func setupNewsTableView() {
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        newsTableView.backgroundColor = .clear
        newsTableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        newsTableView.delegate = presenter?.tableViewHelper
        newsTableView.dataSource = presenter?.tableViewHelper
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.register(NewsTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsTableViewHeaderView.identifier)
    }
}
