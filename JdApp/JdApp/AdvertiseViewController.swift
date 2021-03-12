//
//  AdvertiseViewController.swift
//  JDApp
//
//  Created by chris on 2021/3/12.
//

import UIKit

class AdvertiseViewController: BaseViewController {
    
    // 延迟初始化 timer
    lazy var timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
    // 倒计时的时间
    var seconds = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .kRed
        timeCountDown()
    }
    
    func timeCountDown() {
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler(handler: {
            DispatchQueue.main.async { [weak self] in
                
                // 小于等于 0 时，结束 timer，并进行两个 rootViewController 的切换
                if self!.seconds <= 0 {
                    self!.terminer()
                }
                self!.seconds -= 1
            }
        })
        timer.resume()
    }
    
    func terminer() {
        timer.cancel()
        switchRootController()
    }
    
    //
    // 一个 window 的情况：只用切换 rootViewController 就行
    //
    func switchRootController() {
        let window = UIApplication.shared.windows.first!
        
        // 过渡动画：淡出
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            
                            let old = UIView.areAnimationsEnabled
                            UIView.setAnimationsEnabled(false)
                            window.rootViewController = MainTabBarController()
                            UIView.setAnimationsEnabled(old)

                          }, completion: { _ in
                            // Do Nothing
                          })
    }
}
