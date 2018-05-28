// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "ContentsPocketCSVParser",
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git", from: "0.8.0"),
        .package(url: "https://github.com/onevcat/Rainbow.git", from: "3.0.0")

    ],
    targets: [
        .target(
            name: "ContentsPocketCSVParser",
            dependencies: [
                "Core",
                "Commander",
                "Rainbow"
            ]
        ),
        .target(
            name: "Core"
        )
    ]
)
