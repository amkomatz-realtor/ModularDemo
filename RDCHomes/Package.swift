// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RDCHomes",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RDCHomes",
            targets: ["RDCHomes"]
        ),
    ],
    dependencies: [
        .package(path: "RDCCore"),
        .package(path: "RDCBusiness"),
        .package(url: "https://github.com/nalexn/ViewInspector", from: "0.9.7"),
    ],
    targets: [
        .target(
            name: "RDCHomes",
            dependencies: ["RDCCore", "RDCBusiness"]
        ),
        .testTarget(
            name: "RDCHomesTests",
            dependencies: ["RDCHomes", "ViewInspector"]
        ),
    ]
)
