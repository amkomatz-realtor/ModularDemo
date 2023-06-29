// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RDCFeed",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RDCFeed",
            targets: ["RDCFeed"]
        ),
    ],
    dependencies: [
        .package(path: "RDCCore"),
        .package(path: "RDCBusiness"),
    ],
    targets: [
        .target(
            name: "RDCFeed",
            dependencies: ["RDCCore", "RDCBusiness"]
        ),
        .testTarget(
            name: "RDCFeedTests",
            dependencies: ["RDCFeed"]
        ),
    ]
)
