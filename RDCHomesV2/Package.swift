// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RDCHomesV2",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RDCHomesV2",
            targets: ["RDCHomesV2"]
        ),
    ],
    dependencies: [
        .package(path: "RDCCore"),
        .package(path: "RDCBusiness"),
        .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "0.11.0"),
    ],
    targets: [
        .target(
            name: "RDCHomesV2",
            dependencies: ["RDCCore", "RDCBusiness"]
        ),
        .testTarget(
            name: "RDCHomesV2Tests",
            dependencies: ["RDCHomesV2", .product(name: "CustomDump", package: "swift-custom-dump")]
        ),
    ]
)
