//
//  NSRegularExpression+Matches.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import Foundation

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
