//
//  AppDelegate.swift
//  JDApp
//
//  Created by qingye on 2021/3/5.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.backgroundColor = .white
//        window?.rootViewController = AdvertiseViewController() // 修改这里
//        window?.makeKeyAndVisible()
//
//        return true
//    }
    
    // 多个 window：
    // 第 1 个用于主app；
    // 第 2 个用于显示广告页；
    var windows: [UIWindow]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 后一个 window 盖在前一个之上，可以通过：
        // windows?[下标].makeKeyAndVisible() 来切换显示
        windows = [
            addWindowWithVC(MainTabBarController()),
            addWindowWithVC(AdvertiseViewController())
        ]
        
        return true
    }

    func addWindowWithVC(_ vc: UIViewController) -> UIWindow {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return window
    }
}

