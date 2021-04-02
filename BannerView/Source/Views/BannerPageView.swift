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

class BannerPageView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    fileprivate var urls: [String]?
    fileprivate var loop: Bool = true
    fileprivate var timer: Timer?
    
    var bannerDelegate: BannerDelegate?
    
    public func setUrls(_ urls: [String]) {
        // 原始数据：[a, b, c]
        self.urls = urls
        reData()
        startTimer()
    }
    
    public func setLoop(_ loop: Bool) {
        self.loop = loop
    }
    
    func reData() {
        // 如果支持无限循环，数据变为：[c, a, b, c, a]
        if loop {
            urls!.insert(urls!.last!, at: 0)
            urls!.append(urls![1])
        }
        
        reloadData()
        layoutIfNeeded()
        
        if loop {
            // 如果无限循环，因为数据前、后都额外添加了两项，所以，原来下标为 0 的现在变成了 1
            scrollToItem(at: IndexPath(row: loop ? 1 : 0, section: 0),
                         at: UICollectionView.ScrollPosition(rawValue: 0),
                         // 重新定位下标时，不要动画，否则用户会觉得很奇怪
                         animated: false)
        }
    }

    // 如果是循环滚动，要在滚动结束后计算是否需要重新定位
    func redirectPosition() {
        // 计算 page 下标 = 水平滚动偏移值 / 宽度
        var idx = Int(contentOffset.x / frame.size.width)
        
        // 如果开启了无限循环，则需要在每次滚动结束后，判断是否需要重新定位
        if loop {
            // 以 [c, a, b, c, a] 为例
            if idx == 0 {
                // 如果 idx == 0，表明已经滑到最左侧的 c，我们需要将其滚动到【倒数第2位】
                scrollToItem(at: IndexPath(row: urls!.count - 2, section: 0), at: UICollectionView.ScrollPosition(rawValue: 0), animated: false)
                idx = urls!.count - 3
            } else if idx == urls!.count - 1 {
                // 如果 idx == 最后，表明已经滑到最右侧的 a，我们需要将其滚动到【第1位】
                scrollToItem(at: IndexPath(row: 1, section: 0), at: UICollectionView.ScrollPosition(rawValue: 0), animated: false)
                idx = 0
            } else {
                idx -= 1
            }
        }

        bannerDelegate?.didPageChange(idx: idx)
    }
    
    // MARK: UICollectionViewDelegate
    
    // 当执行 setContentOffset 或者 scrollRectVisible 完成时，且 animated = true 时，该方法会被执行
    // 注：如果 animated = false 该方法是不会被调用的
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        redirectPosition()
    }
    
    // 用户手指触摸产生的滚动才会调用该方法
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        redirectPosition()
    }

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBannerViewCell, for: indexPath) as! BannerViewCell
    
        let url = urls![indexPath.row]
        // SDWebImage 负责下载并加载图片
        cell.imageView?.sd_setImage(with: URL(string: url), placeholderImage: nil)
        
        return cell
    }
}

extension BannerPageView {
    // 便利构造器，调用方只需给出 frame，layout 由该 BannerView 内部实现
    convenience init(frame: CGRect, loop: Bool = true) {
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

// 扩展：处理定时器
extension BannerPageView {
    func startTimer() {
        endTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] _ in
            self?.next()
        })
    }
    
    // 结束定时器
    func endTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func next() {
        let idx = Int(contentOffset.x / frame.size.width)
        scrollToItem(at: IndexPath(row: idx + 1, section: 0), at: UICollectionView.ScrollPosition(rawValue: 0), animated: true)
    }

    // 用户手指触摸停止定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        endTimer()
    }
    
    // 松开后重启定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}
