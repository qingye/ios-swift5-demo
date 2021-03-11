//
//  HomeViewController.swift
//  JDApp
//
//  Created by qingye on 2021/3/6.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "首页"
        view.backgroundColor = .green
        
        let label = UILabel(frame: CGRect.zero)
        label.text = "HomeViewController"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // 设置 label 支持事件交互
        label.isUserInteractionEnabled = true
        // 添加 tap 手势，以及响应方法
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap)))
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func tap() {
        // push 到下一级页面
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}
