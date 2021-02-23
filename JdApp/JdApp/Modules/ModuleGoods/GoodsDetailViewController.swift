//
//  GoodsDetailViewController.swift
//  JdApp
//
//  Created by qingye on 2021/2/20.
//

import UIKit

class GoodsDetailViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        navigationItem.title = "商品详情"
        navigationController?.navigationBar.backgroundColor = .yellow
    }
    
    func initView() {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "商品详情"
        label.tintColor = .black
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
