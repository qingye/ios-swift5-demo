// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    // 库名
    name: "BannerView",
    
    // 支持的平台列表
    platforms: [.iOS(.v10)],
    
    // 对外支持的功能
    products: [
        .library(name: "BannerView", targets: ["BannerView"]),
    ],
    
    // 外部依赖
    dependencies: [
        // 依赖 SDWebImage
        .package(name: "SDWebImage", url: "https://gitee.com/mirrors/SDWebImage", from: "5.1.0")
    ],

    // 指定源码目录（如果不指定，默认目录名是：Sources/*.*）
    targets: [
        .target(name: "BannerView", dependencies: ["SDWebImage"], path: "Source")
    ],
    
    // 支持的 swift 版本，从 5 开始
    swiftLanguageVersions: [.v5]
)
