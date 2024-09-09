// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KYUIKit",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(name: "KYUIKit", targets: ["KYUIKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Kyle-Ye/KYFoundation.git", from: "0.0.2"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1"),
        .package(url: "https://github.com/buh/CompactSlider.git", from: "1.1.6"),
    ],
    targets: [
        .target(
            name: "KYUIKit",
            dependencies: [
                .product(name: "KYFoundation", package: "KYFoundation"),
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "CompactSlider", package: "CompactSlider"),
            ]
        ),
        .testTarget(name: "KYUIKitTests", dependencies: [
            "KYUIKit"
        ]),
    ]
)
