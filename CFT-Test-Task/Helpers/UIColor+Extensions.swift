//
//  UIColor+Extensions.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 20.04.2023.
//

import UIKit

extension UIColor {
    static var shiftRed: UIColor {
        UIColor(named: "ShiftRed") ?? .red
    }
    
    static var shiftLightGray: UIColor? {
        UIColor(named: "ShiftLightGray") ?? .black
    }
    
    static var shiftGray: UIColor? {
        UIColor(named: "ShiftGray") ?? .red
    }
    
    static var shiftCellBackground: UIColor? {
        UIColor(named: "ShiftCellBackground") ?? .red
    }
}
