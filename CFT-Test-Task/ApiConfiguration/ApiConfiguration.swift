//
//  ApiConfiguration.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 24.04.2023.
//

import Foundation

struct Constants {
    static let apiKey = "732ee542c3d84ab28a1f471a5978a44c"
    static let newsAPIString = "https://newsapi.org"
    static let newsAPIURL = URL(string: newsAPIString)!
}

struct ApiConfiguration {
    let apiKey: String
    let newsAPIString: String
    let newsAPIURL: URL
    
    static var standard: ApiConfiguration {
        return ApiConfiguration(
            apiKey: Constants.apiKey,
            newsAPIString: Constants.newsAPIString,
            newsAPIURL: Constants.newsAPIURL)
    }
}
