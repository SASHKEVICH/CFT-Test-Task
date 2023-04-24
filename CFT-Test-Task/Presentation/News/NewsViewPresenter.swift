//
//  NewsViewPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

protocol NewsViewPresenterTableViewHelperProtocol: AnyObject {
    var news: [News] { get set }
}

protocol NewsViewPresenterProtocol {
    var view: NewsViewControllerProtocol? { get set }
    var tableViewHelper: NewsTableViewHelperProtocol { get set }
    func viewDidLoad()
}

final class NewsViewPresenter: NewsViewPresenterProtocol {
    weak var view: NewsViewControllerProtocol?
    var tableViewHelper: NewsTableViewHelperProtocol
    
    var news: [News] = [
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
        News(title: "kdkdkd"), News(title: "kdkdkd1"), News(title: "kdkdkd123"),
    ]
    
    func viewDidLoad() {
        print(#function)
    }
    
    init(tableViewHelper: NewsTableViewHelperProtocol) {
        self.tableViewHelper = tableViewHelper
        tableViewHelper.presenter = self
    }
}

extension NewsViewPresenter: NewsViewPresenterTableViewHelperProtocol {
    
}
