// swift-tools-version:5.5

import PackageDescription

var products: [Product] = []
var targets: [Target] = []


// MARK: - NFCKit
products += [
    .library(name: "NFCKit", targets: ["NFCKit"]),
]
targets += [
    .target(name: "NFCKit", dependencies: [
        "NFCKitCore",
    ]),
    .testTarget(name: "NFCKitTests", dependencies: ["NFCKit"]),
]


// MARK: - NFCKitCore
products += [
    .library(name: "NFCKitCore", targets: ["NFCKitCore"]),
]
targets += [
    .target(name: "NFCKitCore"),
    .testTarget(name: "NFCKitCoreTests", dependencies: ["NFCKitCore"]),
]


let package = Package(
    name: "TRETNFCKit",
    defaultLocalization: "en",
    platforms: [.iOS(.v9), .macOS(.v10_10), .tvOS(.v9), .watchOS(.v2)],
    products: products,
    targets: targets
)
