// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SwiftLED",
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.3.1"),
        .package(url: "https://github.com/uraimo/WS281x.swift.git", from: "2.0.4"),
    ],
    targets: [
        .target(
            name: "SwiftLED",
            dependencies: [
                "SwiftyGPIO",
                "WS281x"
            ]
        )
    ]
)
