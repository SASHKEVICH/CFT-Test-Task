//
//  News.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 24.04.2023.
//

import Foundation

public struct News: Decodable {
    struct Source: Decodable {
        let id: String?
        let name: String?
    }
    
    let title: String?
    let author: String?
    let source: Source?
    let url: URL
}
