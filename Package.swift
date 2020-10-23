// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ErrorHandling",
    platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(name: "ErrorHandling", targets: ["ErrorHandling"]),
    ],
    targets: [
        .target(name: "ErrorHandling"),
    ]
)
