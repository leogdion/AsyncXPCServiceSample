// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncXPCServiceSample",
    platforms: [.macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AsyncXPC",
            targets: ["AsyncXPC"]
        ),

        .library(
          name: "AsyncClient", targets: ["AsyncClient"]
        )
    ],
    dependencies:  [
      .package(url: "https://github.com/ChimeHQ/AsyncXPCConnection.git", from: "1.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
          name: "AsyncXPC", dependencies: ["AsyncServiceXPC", "AsyncService"]
        ),
        .target(
          name: "AsyncService"
        ),
        .target(
          name: "AsyncClient",
          dependencies: ["AsyncXPCConnection", "AsyncServiceXPC", "AsyncService"]
        ),
        .target(
          name: "AsyncServiceXPC"
        )
    ]
)
