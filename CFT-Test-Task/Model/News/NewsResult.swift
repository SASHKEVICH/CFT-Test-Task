//
//  NewsResult.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 24.04.2023.
//

import Foundation

public struct NewsResult: Decodable {
    public let news: [News]
    
    public init(news: [News]) {
        self.news = news
    }
    
    enum CodingKeys: String, CodingKey {
        case news = "articles"
    }
}
