// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRegexExtractor",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/kylef/Spectre.git", from: "0.9.0"),
        .package(url: "https://github.com/kylef/PathKit.git", from: "0.9.2"),
        .package(url: "https://github.com/kingcos/CommandLine.git", from: "4.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftRegexExtractor",
            dependencies: [
                "RegexExtractorKit",
                "CommandLine"
            ]),
        .target(
            name: "RegexExtractorKit",
            dependencies: [
                "Spectre",
                "PathKit"
            ]),
        .testTarget(
            name: "RegexExtractorKitTests",
            dependencies: [
                "RegexExtractorKit",
                "Spectre",
                "PathKit"
            ]),
    ]
)
