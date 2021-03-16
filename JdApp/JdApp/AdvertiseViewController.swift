//
//  AdvertiseViewController.swift
//  JDApp
//
//  Created by chris on 2021/3/12.
//

import UIKit
import CircleProgressView

class AdvertiseViewController: BaseViewController {
    
    // 延迟初始化 timer
    lazy var timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
    // 倒计时的时间
    var seconds = 5
    // 延迟初始化 View，并且不写死位置及大小，由后面的约束来给定
    lazy var progress: CircleProgressView = CircleProgressView(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .kRed
        countDown()
    }
    
    // iOS 11 新API，可以获取 SafeArea 的边距值
    // 竖屏：top & bottom >= 0; left & right = 0
    // 横屏：top = 0; bottom & left & right >= 0
    override func viewSafeAreaInsetsDidChange() {
        // 一般来说，电商类 APP 在启动后，都会有一个 活动页/广告页
        // 我们可以在这个页面获取 safeArea，然后全局设置
        UIApplication.shared.windows.first?.setSafeAreaTop(view.safeAreaInsets.top)
    }
    
    func countDown() {
        // 用代码创建的所有view ，translatesAutoresizingMaskIntoConstraints 默认是YES
        // 用IB创建的所有 view ，translatesAutoresizingMaskIntoConstraints 默认是(autoresize布局: YES, autolayout布局: NO)
        // 这里我们用约束来布局（autolayout）
        
        // 为什么 translatesAutoresizingMaskIntoConstraints 使用约束布局时候，就要设置为 false（OC: NO）？
        // translatesAutoresizingMaskIntoConstraints 的本意是将 frame 布局 自动转化为约束布局，
        // 转化的结果是为这个视图自动添加所有需要的约束，如果我们这时给视图添加自己创建的约束就一定会约束冲突
        progress.translatesAutoresizingMaskIntoConstraints = false

        // 允许用户点击后直接跳过进入下一页
        progress.isUserInteractionEnabled = true
        progress.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.terminer)))
        
        view.addSubview(progress)
        
        // 约束：
        // 1. 宽高均 64；
        // 2. 距离屏幕上边缘(top margin) = 50
        // 3. 距离屏幕右边缘(trailing margin) = -30
        NSLayoutConstraint.activate([
            progress.widthAnchor.constraint(equalToConstant: 64.0),
            progress.heightAnchor.constraint(equalToConstant: 64.0),
            progress.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        // 开始动画，时长为倒计时，动画从 0.0 -> 1.0
        progress.setProgress(1.0, duration: Double(seconds), animated: true)
        
        // 开始倒计时
        timeCountDown()
    }
    
    func timeCountDown() {
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler(handler: {
            DispatchQueue.main.async { [weak self] in
                
                // 小于等于 0 时，结束 timer，并进行两个 rootViewController 的切换
                if self!.seconds <= 0 {
                    self!.terminer()
                } else {
                    // 倒计时中，不断设置 label 的内容
                    self!.progress.setContent(String(self!.seconds))
                }
                self!.seconds -= 1
            }
        })
        timer.resume()
    }
    
    @objc func terminer() {
        timer.cancel()
//        switchRootController()
        switchWindow()
    }
    
    // 同样两种方式可以实现：广告页 -> 主页面：
    // 1. 两个 window 来分别控制不同的业务，然后基于过渡动画来切换 window；
    // 2. 一个 window，两个 vc，分别是 主vc 和 广告vc，通过修改 window.rootViewController 来完成；
    func switchWindow() {
        // 第2个 window（广告窗口）
        let window = UIApplication.shared.windows.last!
        
        // 过渡动画：淡出
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {

                            // 临时保存 UIView 是否开启动画的状态（默认是开启）
                            // 之所以先禁止，是防止存在其它动画影响了当前动画
                            // ----------------------------------------
                            // 设置了禁止动画后：
                            // 1. 当前所有正在执行动画的没有任何影响
                            // 2. 未执行的将不会执行动画
                            // ----------------------------------------
                            //
                            // 因为我们这个回调是动画已经开始，所以，并不会被强制停止,
                            // 最后再恢复 UIView 是否开启动画的状态即可
                            let old = UIView.areAnimationsEnabled
                            UIView.setAnimationsEnabled(false)
                            window.alpha = 0
                            UIView.setAnimationsEnabled(old)

                          }, completion: { _ in
                            // 切换到主 window，即我们的 MainTabBarController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                          })
    }
    
    //
    // 一个 window 的情况：只用切换 rootViewController 就行
    //
//    func switchRootController() {
//        let window = UIApplication.shared.windows.first!
//
//        // 过渡动画：淡出
//        UIView.transition(with: window,
//                          duration: 0.5,
//                          options: .transitionCrossDissolve,
//                          animations: {
//
//                            let old = UIView.areAnimationsEnabled
//                            UIView.setAnimationsEnabled(false)
//                            window.rootViewController = MainTabBarController()
//                            UIView.setAnimationsEnabled(old)
//
//                          }, completion: { _ in
//                            // Do Nothing
//                          })
//    }
}
