//
//  BaseViewController.swift
//  JdApp
//
//  Created by qingye on 2021/2/19.
//

import UIKit

class BaseViewController: UIViewController {
    var hideNavigationBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetNavigationBar()
        
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }
    
    public func resetNavigationBar() {
        if hideNavigationBar {
            navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "返回", style: .done, target: nil, action: nil)
    }
}
