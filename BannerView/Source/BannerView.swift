//
//  BannerView.swift
//  Banner
//
//  Created by qingye on 2021/3/2.
//

import UIKit
import SDWebImage

// 仅该文件内变量可见
// 重复使用 cell 的 identifier
fileprivate let kBannerViewCell = "BannerViewCell"

public class BannerView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    fileprivate var urls: [String]?
    fileprivate var loop: Bool = true
    
    public func setUrls(_ urls: [String]) {
        // 原始数据：[a, b, c]
        self.urls = urls
        
        // 如果支持无限循环，数据变为：[c, a, b, c, a]
        if loop {
            self.urls?.insert(urls.last!, at: 0)
            self.urls?.append(urls.first!)
        }
        
        reloadData()
        layoutIfNeeded()
        
        // 如果无限循环，因为数据前、后都额外添加了两项，所以，原来下标为 0 的现在变成了 1
        scrollToItem(at: IndexPath(row: loop ? 1 : 0, section: 0),
                     at: UICollectionView.ScrollPosition(rawValue: 0),
                     // 重新定位下标时，不要动画，否则用户会觉得很奇怪
                     animated: false)
    }
    
    // MARK: UICollectionViewDelegate
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 如果开启了无限循环，则需要在每次滚动结束后，判断是否需要重新定位
        if loop {
            // 当前可视 cell 的下标，是一个范围值 = 屏幕中可见数 + 前 + 后
            let ip = indexPath(for: visibleCells.first!)!
            
            // 以 [c, a, b, c, a] 为例
            if ip.row == 0 {
                // 如果 row == 0，表明已经滑到最左侧的 c，我们需要将其滚动到【倒数第2位】
                scrollToItem(at: IndexPath(row: urls!.count - 2, section: 0), at: UICollectionView.ScrollPosition(rawValue: 0), animated: false)
            } else if ip.row == urls!.count - 1 {
                // 如果 row == 最后，表明已经滑到最右侧的 a，我们需要将其滚动到【第1位】
                scrollToItem(at: IndexPath(row: 1, section: 0), at: UICollectionView.ScrollPosition(rawValue: 0), animated: false)
            }
        }
    }

    // MARK: UICollectionViewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urls?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBannerViewCell, for: indexPath) as! BannerViewCell
    
        let url = urls![indexPath.row]
        // SDWebImage 负责下载并加载图片
        cell.imageView?.sd_setImage(with: URL(string: url), placeholderImage: nil)
        
        return cell
    }
}

extension BannerView {
    // 便利构造器，调用方只需给出 frame，layout 由该 BannerView 内部实现
    public convenience init(frame: CGRect, loop: Bool = true) {
        let layout = UICollectionViewFlowLayout()
        // 这里是实现轮播，所以统一设置每一个 cell 的宽高
        // 如果想设置每一个 cell 的不同宽高，需要实现 collectionView(_:layout:sizeForItemAt:)
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        // 水平方向滚动
        layout.scrollDirection = .horizontal
        // 行最小间距（同一行 item 之间的水平间距）
        layout.minimumLineSpacing = 0
        // 列最小间距（相邻两行同一列 item 之间的垂直间距）
        layout.minimumInteritemSpacing = 0
        
        // 必需调用 self.init，详见
        //《iOS Swift5 构造函数分析（一）：关键字 designated、convenience、required》
        // https://juejin.cn/post/6932885089546141709
        self.init(frame: frame, collectionViewLayout: layout)
        
        // 是否无限循环，默认 = true
        self.loop = loop
        
        // 自己实现委托
        delegate = self
        // 自己实现数据源
        dataSource = self
        
        // 注册 cell，可以重复使用
        register(BannerViewCell.self, forCellWithReuseIdentifier: kBannerViewCell)
        // 默认背景：白色
        backgroundColor = .white
        // 每一个 item 为一页
        isPagingEnabled = true
        // 不显示水平滚动条
        showsHorizontalScrollIndicator = false
        // 不允许回弹
        bounces = false
    }
}
