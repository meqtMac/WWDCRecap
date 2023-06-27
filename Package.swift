// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Concurrency",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
   dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-async-algorithms.git", .upToNextMajor(from: "0.1.0")),
    ],
    targets: [
        // Target for Concurrency Topics
        .executableTarget(
            name: "Concurrency",
            dependencies: [
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ]
        ),
        
        
        // Target for rich documentation with Swift-DocC
        .target(
            name: "DocCDemo"
        ),
        
        
        .executableTarget(
            name: "Exec",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections")
            ],
            resources: [
                .copy("Resources/")
            ]
        )
   ]
)
