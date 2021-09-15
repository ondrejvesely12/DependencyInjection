// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjection",
    products: [
        .library(
            name: "DependencyInjection",
            targets: ["DependencyInjection"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DependencyInjection",
            dependencies: []
        ),
        .testTarget(
            name: "DependencyInjectionTests",
            dependencies: ["DependencyInjection"]
        ),
    ]
)
