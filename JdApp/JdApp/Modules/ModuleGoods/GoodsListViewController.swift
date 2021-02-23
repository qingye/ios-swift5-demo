//
//  GoodsListViewController.swift
//  JdApp
//
//  Created by qingye on 2021/2/23.
//

import UIKit

class GoodsListViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        navigationItem.title = "商品列表"
        navigationController?.navigationBar.backgroundColor = .orange
    }
    
    func initView() {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapLabel)))
        
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "商品列表"
        label.tintColor = .black
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func tapLabel() {
        self.navigationController?.pushViewController(GoodsDetailViewController(), animated: true)
    }
}
