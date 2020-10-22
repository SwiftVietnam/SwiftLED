// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SwiftLED",
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "SwiftLED",
            dependencies: [
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime")
            ]
        ),
    ]
)
