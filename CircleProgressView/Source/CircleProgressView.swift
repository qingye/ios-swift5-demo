//
//  CircleProgressView.swift
//  demo
//
//  Created by chris on 2021/3/15.
//

import UIKit

fileprivate let StartAngle = CGFloat(Double.pi / 2)

public class CircleProgressView: UIView {
    // 延迟初始化背景层，采用 fill 来绘层背景
    private lazy var bgLayer: CAShapeLayer = CAShapeLayer()
    // 延迟初始化进度条层，采用 stroke 来绘制边框
    private lazy var progressLayer: CAShapeLayer = CAShapeLayer()
    // 进度条百分比（最小为 0.0，最大为 1.0）
    private var progress: Double = 0
    // 延迟初始化标签文本内容
    private lazy var label: UILabel = UILabel(frame: CGRect.zero)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    // 仅初始化 layer & label，以及颜色，后续再给定实际大小和约束
    func initView() {
        // fillColor   用于背景颜色填充
        // strokeColor 用于线条颜色
        
        // 0.25 透明度的白色背景
        bgLayer.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        layer.addSublayer(bgLayer)
        
        // 边框全白，边框宽度为 4
        progressLayer = CAShapeLayer()
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        progressLayer.lineWidth = 4.0
        layer.addSublayer(progressLayer)
        
        // 标签字体颜色为纯白
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        // 使用约束来布局
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }
    
    
    
    // 布局 resize 时会触发该方法
    public override func layoutSubviews() {
        super.layoutSubviews()

        // 因为 宽 = 高，所以，圆角为宽 or 高的一半即可
        let radius = bounds.height / 2
        bgLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath

        // 设置 start 从 12点钟方向开始（默认是3点钟方向）
        // end = 360度 * progress - start
        // 设置为 顺时针 方向
        let end = CGFloat(Double.pi * 2 * progress) - StartAngle
        progressLayer.path = UIBezierPath(arcCenter: CGPoint(rect: bounds), radius: radius,
                                          startAngle: -StartAngle, endAngle: end,
                                          clockwise: true).cgPath
        
        // 设置 label 的中心点 = self 的中心点
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    public func setProgress(_ progress: Double, duration: Double, animated: Bool) {
        // 进度条目标值，即 0.0 -> progress
        self.progress = progress
        // 初始化 label
        label.text = "\(duration)s"

        // 创建进度条动画，时长 = duration
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = duration
            animation.fromValue = 0
            animation.toValue = 1
            progressLayer.add(animation, forKey: nil)
        }
    }
    
    public func setContent(_ text: String) {
        label.text = "\(text)s"
    }
}

extension CGPoint {
    // 扩展，取 rect 的中心点
    init(rect: CGRect) {
        self.init(x: rect.width / 2, y: rect.height / 2)
    }
}
