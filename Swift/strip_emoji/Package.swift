// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "strip_emoji",
    products: [
        .library(
            name: "strip_emoji",
            targets: ["strip_emoji"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "strip_emoji",
            dependencies: []),
        .testTarget(
            name: "strip_emojiTests",
            dependencies: ["strip_emoji"]),
    ]
)