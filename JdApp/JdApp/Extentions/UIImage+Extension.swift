//
//  UIImage+Extension.swift
//  JDApp
//
//  Created by chris on 2021/3/3.
//

import UIKit

extension UIImage {
    convenience init(size: CGSize = CGSize.zero, color: UIColor = .white) {
        
        // 创建一个基于位图的上下文，并将其设置为当前上下文
        UIGraphicsBeginImageContext(size)
        
        // 获取当前上下文
        let context = UIGraphicsGetCurrentContext()
        
        // 设置填充色
        context?.setFillColor(color.cgColor)
        // 绘制填充指定区域
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // 获取图形上下文的内容
        let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        
        // 移除当前图形上下文
        UIGraphicsEndImageContext()
        
        self.init(cgImage: cgImage!)
    }
}
