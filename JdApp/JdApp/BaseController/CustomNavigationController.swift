//
//  CustomNavigationController.swift
//  JdApp
//
//  Created by qingye on 2021/2/23.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController is BaseViewController {
            (viewController as! BaseViewController).resetNavigationBar()
        }
    }
}
