// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "MMMocking",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "MMMocking",
            targets: ["MMMocking"]
		)
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MMMockingObjC",
            dependencies: [],
            path: "Sources/MMMockingObjC"
		),
        .target(
            name: "MMMocking",
            dependencies: ["MMMockingObjC"],
            path: "Sources/MMMocking"
		),
        .testTarget(
            name: "MMMockingTests",
            dependencies: ["MMMocking"],
            path: "Tests"
		)
    ]
)
