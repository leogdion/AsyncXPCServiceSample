// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XPCDemo",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "XPCService",
            targets: ["XPCService"]),
        .library(
            name: "XPCDemoService",
            targets: ["XPCDemoService"]),
        .library(
            name: "Service",
            targets: ["Service"]),
    ],
    dependencies:  [
      .package(url: "https://github.com/ChimeHQ/AsyncXPCConnection.git", from: "1.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Service"),
        .target(
            name: "XPCDemo",
            dependencies: ["Service"]
        ),
        .target(
            name: "XPCService",
            dependencies: ["XPCDemoService"]
        ),
        .target(
            name: "XPCDemoService",
            dependencies: ["XPCDemo"]
        )

    ]
)
