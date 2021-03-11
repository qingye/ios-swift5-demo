//
//  CustomNavigationController.swift
//  JDApp
//
//  Created by chris on 2021/3/10.
//

import UIKit

class CustomNavigationController: UINavigationController {
    // 重写 pushViewController 方法，不修改 pushViewController 的逻辑
    // 仅在跳转前，判断目标 VC 是否为一级页面还是二级页面，通过 viewControllers.count 来判断：
    // viewControllers.count > 0，那么目标 VC 肯定是第二个页面（即二级页面），我们就添加上 hidesBottomBarWhenPushed = true
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
