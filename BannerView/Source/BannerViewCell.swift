//
//  BannerViewCell.swift
//  Banner
//
//  Created by qingye on 2021/3/2.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(imageView!)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
