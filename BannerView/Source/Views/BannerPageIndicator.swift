//
//  BannerViewCell.swift
//  Banner
//
//  Created by qingye on 2021/3/2.
//

import UIKit

fileprivate let kGap: CGFloat = 5.0
fileprivate let kBgColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
fileprivate let kFgColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

class BannerPageIndicator: UIView {
    var indicators: [CAShapeLayer] = []
    var curIdx: Int = 0

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
    
    public func setCurIdx(_ idx: Int) {
        indicators[curIdx].fillColor = kBgColor
        curIdx = idx
        indicators[curIdx].fillColor = kFgColor
    }
}
