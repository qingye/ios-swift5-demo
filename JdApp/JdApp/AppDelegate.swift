//
//  AppDelegate.swift
//  JDApp
//
//  Created by qingye on 2021/3/5.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = AdvertiseViewController() // 修改这里
        window?.makeKeyAndVisible()
        
        return true
    }
}

