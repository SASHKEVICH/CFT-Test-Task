//
//  NewsResult.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 24.04.2023.
//

import Foundation

struct NewsResult: Decodable {
    let news: [News]
    
    enum CodingKeys: String, CodingKey {
        case news = "articles"
    }
}
