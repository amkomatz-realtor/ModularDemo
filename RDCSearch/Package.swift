// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RDCSearch",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RDCSearch",
            targets: ["RDCSearch"]
        ),
    ],
    dependencies: [
        .package(path: "RDCCore"),
        .package(path: "RDCBusiness"),
    ],
    targets: [
        .target(
            name: "RDCSearch",
            dependencies: ["RDCCore", "RDCBusiness"]
        ),
        .testTarget(
            name: "RDCSearchTests",
            dependencies: ["RDCSearch"]
        ),
    ]
)
