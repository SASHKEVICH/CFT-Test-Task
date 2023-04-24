//
//  NewsViewPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

protocol NewsViewPresenterTableViewHelperProtocol: AnyObject {
    var news: [News] { get set }
    func didTapNewsCell(_ cell: NewsTableViewCell)
    func requestFetchNewsNextPageIfLastCell(at indexPath: IndexPath)
}

protocol NewsViewPresenterProtocol {
    var view: NewsViewControllerProtocol? { get set }
    var tableViewHelper: NewsTableViewHelperProtocol { get set }
    func requestNews()
}

final class NewsViewPresenter: NewsViewPresenterProtocol {
    private var newsService: NewsServiceProtocol
    
    weak var view: NewsViewControllerProtocol?
    var tableViewHelper: NewsTableViewHelperProtocol
    
    var news: [News] = []
    
    func requestNews() {
        view?.showActivityIndicator()
        
        newsService.fetchNewsNextPage { [weak self] result in
            self?.handleFetchingNews(result: result)
        }
    }
    
    init(tableViewHelper: NewsTableViewHelperProtocol, newsService: NewsServiceProtocol) {
        self.tableViewHelper = tableViewHelper
        self.newsService = newsService
        
        tableViewHelper.presenter = self
    }
}

extension NewsViewPresenter: NewsViewPresenterTableViewHelperProtocol {
    func didTapNewsCell(_ cell: NewsTableViewCell) {
        print("tap cell")
    }
    
    func requestFetchNewsNextPageIfLastCell(at indexPath: IndexPath) {
        let isNextCellLast = indexPath.row + 1 == news.count
        if isNextCellLast {
            requestNews()
        }
    }
}

private extension NewsViewPresenter {
    func handleFetchingNews(result: Result<NewsResult, Error>) {
        switch result {
        case .success(let newsResult):
            self.news += newsResult.articles
            view?.didUpdateNewsAnimated(newsCount: news.count)
            view?.hideActivityIndicator()
        case .failure(let error):
            print(error)
        }
    }
}
