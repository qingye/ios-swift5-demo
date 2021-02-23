//
//  HomeViewController.swift
//  JdApp
//
//  Created by qingye on 2021/2/19.
//

import UIKit

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        hideNavigationBar = true
        super.viewDidLoad()
        self.initView()
    }

    func initView() {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HomeViewController"
        label.tintColor = .black
        
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel))
        label.addGestureRecognizer(tap)
        
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
