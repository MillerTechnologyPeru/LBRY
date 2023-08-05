// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "LBRY",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "LBRY",
            targets: ["LBRY"]
        )
    ],
    targets: [
        .target(
            name: "LBRY"
        ),
        .testTarget(
            name: "LBRYTests",
            dependencies: ["LBRY"]
        )
    ]
)
