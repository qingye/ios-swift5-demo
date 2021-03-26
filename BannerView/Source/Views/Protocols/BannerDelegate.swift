//
//  File.swift
//  
//
//  Created by chris on 2021/3/26.
//

import Foundation

public protocol BannerDelegate: NSObjectProtocol {
    func didPageChange(idx: Int)
}
