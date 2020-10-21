// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SwiftLED",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMinor(from: "3.3.0")),
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.3.1"),
        .package(url: "https://github.com/uraimo/WS281x.swift.git", from: "2.0.4"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            "Vapor",
            "Leaf",
            "SwiftyGPIO",
            "WS281x"            
        ]),
        .target(name: "Run", dependencies: ["App"]),
    ]
)
