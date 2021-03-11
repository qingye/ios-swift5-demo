//
//  ViewController.swift
//  JDApp
//
//  Created by qingye on 2021/3/5.
//

import UIKit

class ViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "二级页面"
        addNavBar(.cyan)
    }
}
