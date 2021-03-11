//
//  Constants.swift
//  JDApp
//
//  Created by qingye on 2021/3/11.
//

import UIKit

/// 宏定义语法只有 OC 才有，而 swift 中是不能使用宏定义语法的；
/// 但是因为命名空间的缘故，我们可以采用变通的方式来实现：
/// 1、定义常量文件；
/// 2、对于 OC 中的无参宏定义，在 swift 中可以定义成 let 变量；
/// 3、对于 OC 中的有参宏定义，在 swift 中可以定义成 func；
/// 由于我们的整个项目共享命名空间，因此，我们就可以在项目内的任何地方直接使用该 swift 中定义的这些公共的常量和函数

/// 类 OC 无参宏定义，使用 let 常量来替代
let kScreenWidth  = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

/// 类 OC 有参宏定义，使用 func 函数来替代
func hexToCGFloat(hexVal: Int, offset: Int = 0, mask: Int = 0xFF, denominator: CGFloat = 255.0) -> CGFloat {
    CGFloat((hexVal >> offset) & mask) / denominator
}
