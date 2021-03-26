//
//  HomeViewController.swift
//  JDApp
//
//  Created by qingye on 2021/3/6.
//

import UIKit
import BannerView

class HomeViewController: BaseViewController {
    
    var bannerView: BannerView?

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
        
        addBannerView()
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func tap() {
        // push 到下一级页面
        navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    func addBannerView() {
        bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        bannerView?.setData([
            "https://cdn-1.blushmark.com/blushmark/upimg/c1/ba/8c0793797057964bfa65a210f76a43aafbd1c1ba.gif",
            "https://cdn-1.blushmark.com/blushmark/upimg/d8/bd/3269b7e78582be3d7d17c194cc32fe8b4d48d8bd.jpg",
            "https://cdn-1.blushmark.com/blushmark/upimg/bd/f8/8c836e32bced64eef2a8d916d50081a38819bdf8.jpg"
        ], true)
        view.addSubview(bannerView!)
    }
}
