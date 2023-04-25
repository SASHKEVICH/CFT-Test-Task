//
//  NewsServiceMock.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import Foundation
import CFT_Test_Task

final class NewsServiceMock: NewsServiceProtocol {
    func fetchNewsNextPage(
        completion: @escaping (Result<NewsResult, Error>) -> Void
    ) {
        let newsResult = NewsResult(news: [])
        completion(.success(newsResult))
    }
}
