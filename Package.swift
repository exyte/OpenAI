// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExyteOpenAI",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ExyteOpenAI",
            targets: ["ExyteOpenAI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/exyte/EventSourceHttpBody.git", .upToNextMajor(from: "0.1.4"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ExyteOpenAI",
            dependencies: [
                .product(name: "EventSourceHttpBody", package: "EventSourceHttpBody")
            ]
        )
    ]
)
