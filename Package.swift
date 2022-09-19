// swift-tools-version: 5.7

import PackageDescription

let packageName = "TRETNFCKit"

let swiftSettings: [SwiftSetting] = [
    .unsafeFlags(
        [
            "-Xfrontend", "-warn-concurrency",
            "-Xfrontend", "-enable-actor-data-race-checks",
        ], .when(configuration: .debug)
    ),
]

var products: [Product] = []
var targets: [Target] = []

@discardableResult
func add(moduleName: String, dependencies: [Target.Dependency] = [], includesTest: Bool) -> Target.Dependency {
    let targetName = "\(packageName)_\(moduleName)"
    products.append(
        .library(name: targetName, targets: [targetName])
    )
    targets.append(
        .target(name: targetName, dependencies: dependencies, path: "Sources/\(moduleName)", swiftSettings: swiftSettings)
    )
    if includesTest {
        targets.append(
            .testTarget(name: "\(packageName)_\(moduleName)Tests", dependencies: [.init(stringLiteral: targetName)], path: "Tests/\(moduleName)Tests", swiftSettings: swiftSettings)
        )
    }
    return .init(stringLiteral: targetName)
}

// MARK: - Modules
add(moduleName: "Core", includesTest: true)

// MARK: - Package
products.append(
    .library(name: packageName, targets: [packageName])
)
targets.append(
    .target(name: packageName, dependencies: targets.filter { !$0.isTest }.map { .init(stringLiteral: $0.name) }, swiftSettings: swiftSettings)
)

let package = Package(
    name: packageName,
    defaultLocalization: "en",
    platforms: [.iOS(.v13), .macOS(.v10_15), .macCatalyst(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: products,
    targets: targets
)
