// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "FastReplace",
    platforms: [.macOS(.v13), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "FastReplace",
            targets: ["FastReplace"]
        ),
    ],
    targets: [
        .target(
            name: "FastReplace"
        ),
        .testTarget(
            name: "FastReplaceTests",
            dependencies: [
                "FastReplace",
            ]
        ),
    ]
)
