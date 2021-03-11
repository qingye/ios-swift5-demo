//
//  UIWindow+Extension.swift
//  JDApp
//
//  Created by chris on 2021/3/5.
//

import UIKit

extension UIWindow {
    static var safeAreaTop: CGFloat = 0
    static var totalHeight: CGFloat = 20 + 44
    
    func setSafeAreaTop(_ top: CGFloat) {
        UIWindow.safeAreaTop = top
        UIWindow.totalHeight = top + 44
    }
}
