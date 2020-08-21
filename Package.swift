// swift-tools-version:5.3

import PackageDescription

var products: [Product] = [
    .library(
        name: "TRETJapanNFCReader",
        targets: ["TRETJapanNFCReader"])
]
var targets: [Target] = [
    .target(
        name: "TRETJapanNFCReader",
        dependencies: [
            "TRETJapanNFCReader-Core",
            "TRETJapanNFCReader-FeliCa",
            "TRETJapanNFCReader-FeliCa-LocalTransitIC",
            "TRETJapanNFCReader-FeliCa-Nanaco",
            "TRETJapanNFCReader-FeliCa-Octopus",
            "TRETJapanNFCReader-FeliCa-Okica",
            "TRETJapanNFCReader-FeliCa-RakutenEdy",
            "TRETJapanNFCReader-FeliCa-TransitIC",
            "TRETJapanNFCReader-FeliCa-UnivCoopICPrepaid",
            "TRETJapanNFCReader-FeliCa-Waon",
        ],
        path: "Sources/TRETJapanNFCReader"),
]


// MARK: - Core
// Required for each targets
products.append(
    .library(
        name: "TRETJapanNFCReader-Core",
        targets: ["TRETJapanNFCReader-Core"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-Core",
        path: "Sources/Core")
)


// MARK: - FeliCa (ISO 18092)
// Required for targets using FeliCa (ISO 18092)
products.append(
    .library(
        name: "TRETJapanNFCReader-FeliCa",
        targets: ["TRETJapanNFCReader-FeliCa"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-FeliCa",
        dependencies: ["TRETJapanNFCReader-Core"],
        path: "Sources/FeliCa/_FeliCa")
)


// MARK: - FeliCa-LocalTransitIC
// Local Transit IC / 地方の交通系IC
// りゅーと
products.append(
    .library(
        name: "TRETJapanNFCReader-FeliCa-LocalTransitIC",
        targets: ["TRETJapanNFCReader-FeliCa-LocalTransitIC"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-FeliCa-LocalTransitIC",
        dependencies: ["TRETJapanNFCReader-FeliCa"],
        path: "Sources/FeliCa/LocalTransitIC/Sources")
)
targets.append(
    .testTarget(
        name: "TRETJapanNFCReader-FeliCa-LocalTransitICTests",
        dependencies: ["TRETJapanNFCReader-FeliCa-LocalTransitIC"],
        path: "Sources/FeliCa/LocalTransitIC/Tests")
)


// MARK: - FeliCa-Nanaco
// nanaco / nanaco
products.append(
    .library(
        name: "TRETJapanNFCReader-FeliCa-Nanaco",
        targets: ["TRETJapanNFCReader-FeliCa-Nanaco"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-FeliCa-Nanaco",
        dependencies: ["TRETJapanNFCReader-FeliCa"],
        path: "Sources/FeliCa/Nanaco/Sources")
)
targets.append(
    .testTarget(
        name: "TRETJapanNFCReader-FeliCa-NanacoTests",
        dependencies: ["TRETJapanNFCReader-FeliCa-Nanaco"],
        path: "Sources/FeliCa/Nanaco/Tests")
)


// MARK: - FeliCa-Octopus
// Octopus / 八達通
products.append(
    .library(
        name: "TRETJapanNFCReader-FeliCa-Octopus",
        targets: ["TRETJapanNFCReader-FeliCa-Octopus"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-FeliCa-Octopus",
        dependencies: ["TRETJapanNFCReader-FeliCa"],
        path: "Sources/FeliCa/Octopus/Sources")
)
targets.append(
    .testTarget(
        name: "TRETJapanNFCReader-FeliCa-OctopusTests",
        dependencies: ["TRETJapanNFCReader-FeliCa-Octopus"],
        path: "Sources/FeliCa/Octopus/Tests")
)


// MARK: - FeliCa-Okica
// OKICA / 沖縄ICカード
products.append(
    .library(
        name: "TRETJapanNFCReader-FeliCa-Okica",
        targets: ["TRETJapanNFCReader-FeliCa-Okica"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-FeliCa-Okica",
        dependencies: ["TRETJapanNFCReader-FeliCa"],
        path: "Sources/FeliCa/Okica/Sources")
)
targets.append(
    .testTarget(
        name: "TRETJapanNFCReader-FeliCa-OkicaTests",
        dependencies: ["TRETJapanNFCReader-FeliCa-Okica"],
        path: "Sources/FeliCa/Okica/Tests")
)


// MARK: - FeliCa-RakutenEdy
// Rakuten Edy / 楽天Edy
products.append(
    .library(
        name: "TRETJapanNFCReader-FeliCa-RakutenEdy",
        targets: ["TRETJapanNFCReader-FeliCa-RakutenEdy"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-FeliCa-RakutenEdy",
        dependencies: ["TRETJapanNFCReader-FeliCa"],
        path: "Sources/FeliCa/RakutenEdy/Sources")
)
targets.append(
    .testTarget(
        name: "TRETJapanNFCReader-FeliCa-RakutenEdyTests",
        dependencies: ["TRETJapanNFCReader-FeliCa-RakutenEdy"],
        path: "Sources/FeliCa/RakutenEdy/Tests")
)


// MARK: - FeliCa-TransitIC
// Transit IC (comply or correspond with CJRC standards) / 交通系IC (CJRC規格準拠または対応)
// Suica, ICOCA, PiTaPa, IruCa, TOICA, PASMO, PASPY, nimoca, Kitaca, SAPICA, SUGOCA, はやかけん, manaca, icsca, etc.
products.append(
    .library(
        name: "TRETJapanNFCReader-FeliCa-TransitIC",
        targets: ["TRETJapanNFCReader-FeliCa-TransitIC"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-FeliCa-TransitIC",
        dependencies: ["TRETJapanNFCReader-FeliCa"],
        path: "Sources/FeliCa/TransitIC/Sources")
)
targets.append(
    .testTarget(
        name: "TRETJapanNFCReader-FeliCa-TransitICTests",
        dependencies: ["TRETJapanNFCReader-FeliCa-TransitIC"],
        path: "Sources/FeliCa/TransitIC/Tests")
)


// MARK: - FeliCa-UnivCoopICPrepaid
// Japanese Univ. Co-op IC Prepaid / 大学生協ICプリペイド
products.append(
    .library(
        name: "TRETJapanNFCReader-FeliCa-UnivCoopICPrepaid",
        targets: ["TRETJapanNFCReader-FeliCa-UnivCoopICPrepaid"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-FeliCa-UnivCoopICPrepaid",
        dependencies: ["TRETJapanNFCReader-FeliCa"],
        path: "Sources/FeliCa/UnivCoopICPrepaid/Sources")
)
targets.append(
    .testTarget(
        name: "TRETJapanNFCReader-FeliCa-UnivCoopICPrepaidTests",
        dependencies: ["TRETJapanNFCReader-FeliCa-UnivCoopICPrepaid"],
        path: "Sources/FeliCa/UnivCoopICPrepaid/Tests")
)


// MARK: - FeliCa-Waon
// WAON / WAON
products.append(
    .library(
        name: "TRETJapanNFCReader-FeliCa-Waon",
        targets: ["TRETJapanNFCReader-FeliCa-Waon"])
)
targets.append(
    .target(
        name: "TRETJapanNFCReader-FeliCa-Waon",
        dependencies: ["TRETJapanNFCReader-FeliCa"],
        path: "Sources/FeliCa/Waon/Sources")
)
targets.append(
    .testTarget(
        name: "TRETJapanNFCReader-FeliCa-WaonTests",
        dependencies: ["TRETJapanNFCReader-FeliCa-Waon"],
        path: "Sources/FeliCa/Waon/Tests")
)


let package = Package(
    name: "TRETJapanNFCReader",
    defaultLocalization: "en",
    platforms: [
        .iOS("9.3"),
        .watchOS(.v2),
        .tvOS("9.2"),
        .macOS(.v10_10),
    ],
    products: products,
    targets: targets,
    swiftLanguageVersions: [.v5]
)
