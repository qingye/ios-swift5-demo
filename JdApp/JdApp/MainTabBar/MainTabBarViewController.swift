//
//  MainTabBarViewController.swift
//  JdApp
//
//  Created by qingye on 2021/2/18.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTabBar()
    }
    
    func initTabBar() {
        self.viewControllers = [
            self.getTabBarItem(HomeViewController(), "首页"),
            self.getTabBarItem(CategoryViewController(), "分类"),
            self.getTabBarItem(FoundViewController(), "发现"),
            self.getTabBarItem(CartViewController(), "购物车"),
            self.getTabBarItem(MineViewController(), "我的")
        ]

        // 设置 tabBar & tabBarItem
        self.setTabBarItemAttributes(bgColor: UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.75))

        // 设置汽泡
        for one in self.tabBar.items! {
            if (one.title == "购物车") {
                one.badgeValue = "99+"
            }
        }
    }
    
    func getTabBarItem(_ vc: UIViewController, _ title: String) -> UIViewController {
        let nav = CustomNavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        return nav
    }
    
    /// 这种方式比较灵活
    func setTabBarItemAttributes(fontName: String = "Courier",
                                 fontSize: CGFloat = 14,
                                 normalColor: UIColor = .gray,
                                 selectedColor: UIColor = .red,
                                 bgColor: UIColor = .white) {
        // tabBarItem 文字大小
        var attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: fontName, size: fontSize)!]
        
        // tabBarItem 文字默认颜色
        attributes[.foregroundColor] = normalColor
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        
        // tabBarItem 文字选中颜色
        attributes[.foregroundColor] = selectedColor
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
        
        // tabBar 背景色
        self.tabBar.barTintColor = bgColor
    }
}
