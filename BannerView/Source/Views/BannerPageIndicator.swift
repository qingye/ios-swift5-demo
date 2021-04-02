//
//  BannerViewCell.swift
//  Banner
//
//  Created by qingye on 2021/3/2.
//

import UIKit

fileprivate let kGap: CGFloat = 5.0
// 半透明白色背景
fileprivate let kBgColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
// 纯实心白色背景
fileprivate let kFgColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

class BannerPageIndicator: UIView {
    var indicators: [CAShapeLayer] = []
    var curIdx: Int = 0

    // 添加小圆点
    public func addCircleLayer(_ nums: Int) {
        if nums > 0 {
            for _ in 0..<nums {
                let circle = CAShapeLayer()
                circle.fillColor = kBgColor
                indicators.append(circle)
                layer.addSublayer(circle)
            }
        }
    }
    
    // 计算并居中排列
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = indicators.count
        let d = bounds.height
        let totalWidth = d * CGFloat(count) + kGap * CGFloat(count)
        let startX = (bounds.width - totalWidth) / 2
        
        for i in 0..<count {
            let x = (d + kGap) * CGFloat(i) + startX
            let circle = indicators[i]
            circle.path = UIBezierPath(roundedRect: CGRect(x: x, y: 0, width: d, height: d), cornerRadius: d / 2).cgPath
        }
        
        setCurIdx(0)
    }
    
    // 设置当前展示的图的下标
    public func setCurIdx(_ idx: Int) {
        // 先修改当前小圆点背景（半透明）
        indicators[curIdx].fillColor = kBgColor
        
        // 修改下标
        curIdx = idx
        
        // 再修改实际对应图片的下标的小圆点背景（纯白色）
        indicators[curIdx].fillColor = kFgColor
    }
}
