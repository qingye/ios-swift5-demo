//
//  UIColor+Extension.swift
//  JDApp
//
//  Created by chris on 2021/3/3.
//

import UIKit

extension UIColor {
    convenience init(hexVal: Int) {
        self.init(red: hexToCGFloat(hexVal: hexVal, offset: 24),
                  green: hexToCGFloat(hexVal: hexVal, offset: 16),
                  blue: hexToCGFloat(hexVal: hexVal, offset: 8),
                  alpha: hexToCGFloat(hexVal: hexVal))
    }
    
    public static let kRed      = UIColor(hexVal: 0xFF6666FF)
    public static let kGreen    = UIColor(hexVal: 0x66FF66FF)
    public static let kBlue     = UIColor(hexVal: 0x6666FFFF)
}
