//
//  NewsViewPresenter.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

protocol NewsViewPresenterTableViewHelperProtocol: AnyObject {
    var news: [News] { get set }
    func didTapNewsCell(at indexPath: IndexPath)
    func requestFetchNewsNextPageIfLastCell(at indexPath: IndexPath)
    func didTapGreetingsButton()
}

protocol NewsViewPresenterProtocol {
    var view: NewsViewControllerProtocol? { get set }
    var tableViewHelper: NewsTableViewHelperProtocol { get set }
    func requestNews()
    func didTapLogoutButton()
}

final class NewsViewPresenter: NewsViewPresenterProtocol {
    private var newsService: NewsServiceProtocol
    private var registrationService: RegistrationServiceAllRemoveProtocol
    
    weak var view: NewsViewControllerProtocol?
    var tableViewHelper: NewsTableViewHelperProtocol
    
    var news: [News] = []
    
    func requestNews() {
        view?.showActivityIndicator()
        
        newsService.fetchNewsNextPage { [weak self] result in
            self?.handleFetchingNews(result: result)
        }
    }
    
    func didTapLogoutButton() {
        registrationService.removeAll()
    }
    
    init(
        tableViewHelper: NewsTableViewHelperProtocol,
        newsService: NewsServiceProtocol,
        registrationService: RegistrationServiceAllRemoveProtocol
    ) {
        self.tableViewHelper = tableViewHelper
        self.newsService = newsService
        self.registrationService = registrationService
        
        tableViewHelper.presenter = self
    }
}

// MARK: - NewsViewPresenterTableViewHelperProtocol
extension NewsViewPresenter: NewsViewPresenterTableViewHelperProtocol {
    func didTapNewsCell(at indexPath: IndexPath) {
        let selectedNews = news[indexPath.row]
        view?.showNewsInSafari(with: selectedNews.url)
    }
    
    func requestFetchNewsNextPageIfLastCell(at indexPath: IndexPath) {
        let isNextCellLast = indexPath.row + 1 == news.count
        if isNextCellLast {
            requestNews()
        }
    }
    
    func didTapGreetingsButton() {
        view?.showGreetings()
    }
}

// MARK: - Private methods
private extension NewsViewPresenter {
    func handleFetchingNews(result: Result<NewsResult, Error>) {
        switch result {
        case .success(let newsResult):
            self.news += newsResult.news
            view?.didUpdateNewsAnimated(
                newsCount: news.count,
                batchAmount: newsResult.news.count)
            view?.hideActivityIndicator()
        case .failure(let error):
            print(error)
        }
    }
}
