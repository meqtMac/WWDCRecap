// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWDCRecap",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(name: "DocCDemo", targets: ["DocCDemo"]),
        .library(name: "SwiftPackagePlugin", targets: ["SwiftPackagePlugin"]),
        .library(name: "SwiftTypes", targets: ["SwiftTypes"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-async-algorithms.git", .upToNextMajor(from: "0.1.0")),
    ],
    targets: [
        .executableTarget(
            name: "Concurrency",
            dependencies: [
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
                .product(name: "Collections", package: "swift-collections")
            ],
            swiftSettings: [
                .unsafeFlags(["-strict-concurrency=complete"])
            ]
        ),
        .target(
            name: "DocCDemo"
        ),
        .executableTarget(
            name: "RegexDemo"
        ),
        .executableTarget(
            name: "DSLDemo"
        ),
        .target(
            name: "SwiftTypes"
        ),
        .executableTarget(
            name: "customStringInteroperation"
        ),
        .target(name: "MEQTOCInteroperabilty"),
        .target(
            name: "SwiftPackagePlugin"
        ),
    ]
)

