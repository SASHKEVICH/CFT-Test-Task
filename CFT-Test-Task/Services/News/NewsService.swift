//
//  NewsService.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 24.04.2023.
//

import Foundation

enum NewsServiceError: Error {
    case fetchNewsStillRunning
}

protocol NewsServiceProtocol {
    func fetchNewsNextPage(completion: @escaping (Result<NewsResult, Error>) -> Void)
}

final class NewsService: NewsServiceProtocol {
    private let urlSession = URLSession.shared
    private var fetchNewsTask: URLSessionTask?
    
    private let apiConfiguration = ApiConfiguration.standard
    private var lastLoadedPage: Int?
    
    private(set) var newsResult: NewsResult?
    
    func fetchNewsNextPage(
        completion: @escaping (Result<NewsResult, Error>) -> Void
    ) {
        assert(Thread.isMainThread)
        guard !fetchNewsTask.isStillRunning else {
            completion(.failure(NewsServiceError.fetchNewsStillRunning))
            return
        }
        
        let nextPage = calculateNextPage()
        guard let request = nextNewsPageRequest(page: nextPage) else { return }
        let task = urlSession.startLoadingObjectFromNetwork(with: request) { [weak self] (result: Result<NewsResult, Error>) -> Void in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.handleFetchingNewsResult(result: result, completion: completion)
                self.fetchNewsTask = nil
            }
        }
        self.fetchNewsTask = task
        task.resume()
    }
}

// MARK: - Private Methods
private extension NewsService {
    func handleFetchingNewsResult(
        result: Result<NewsResult, Error>,
        completion: (Result<NewsResult, Error>) -> Void
    ) {
        switch result {
        case .success(let newsResult):
            self.newsResult = newsResult
            completion(.success(newsResult))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func calculateNextPage() -> Int {
        guard var lastLoadedPage = lastLoadedPage else {
            self.lastLoadedPage = 1
            return 1
        }
        lastLoadedPage += 1
        self.lastLoadedPage = lastLoadedPage
        return lastLoadedPage
    }
    
    func nextNewsPageRequest(page: Int) -> URLRequest? {
        guard var newsPageUrlComponents = URLComponents(string: apiConfiguration.newsAPIString) else {
            assertionFailure("Unable to construct news url components")
            return nil
        }
        
        newsPageUrlComponents.path = "/v2/everything"
        newsPageUrlComponents.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "10"),
            URLQueryItem(name: "language", value: "ru"),
            URLQueryItem(name: "q", value: "tech"),
            URLQueryItem(name: "apiKey", value: apiConfiguration.apiKey)
        ]
        
        guard let url = newsPageUrlComponents.url else {
            assertionFailure("Unable to get news url")
            return nil
        }
        
        let request = URLRequest(url: url)
        return request
    }
}
