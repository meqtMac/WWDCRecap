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
        .library(name: "SwiftGeneric", targets: ["SwiftGeneric"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-async-algorithms.git", .upToNextMajor(from: "0.1.0")),
    ],
    targets: [
        // Target for Concurrency Topics
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
        
        // Target for rich documentation with Swift-DocC
        .target(
            name: "DocCDemo"
        ),
        
        // Target for Swift Regex
        .executableTarget(
            name: "RegexDemo"
        ),
        
        // Target for Swift's Generic
        .target(
            name: "SwiftGeneric"
        ),
        
        // Target for Swift Package Plugin
        .target(
            name: "SwiftPackagePlugin"
        ),
    ]
)

