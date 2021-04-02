//
//  BannerView.swift
//  Banner
//
//  Created by qingye on 2021/3/2.
//

import UIKit

public class BannerView: UIView, BannerDelegate {
    fileprivate var banner: BannerPageView?
    fileprivate var indicators: BannerPageIndicator?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        
        banner = BannerPageView(frame: frame, loop: true)
        // 设置委托为自己
        banner?.bannerDelegate = self
        addSubview(banner!)
        
        indicators = BannerPageIndicator(frame: CGRect.zero)
        indicators?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicators!)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setData(_ urls: [String], _ loop: Bool) {
        banner?.setLoop(loop)
        banner?.setUrls(urls)
        adjustIndicator(urls.count)
    }
    
    // MARK: BannerDelegate
    public func didPageChange(idx: Int) {
        indicators?.setCurIdx(idx)
    }
    
    func adjustIndicator(_ count: Int) {
        indicators?.addCircleLayer(count)
        NSLayoutConstraint.activate([
            indicators!.widthAnchor.constraint(equalToConstant: frame.width),
            indicators!.heightAnchor.constraint(equalToConstant: 8),
            indicators!.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicators!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    @objc func handleTap() {
        print("handleTap ==== \(String(describing: indicators?.curIdx))")
    }
}
