// swift-tools-version: 6.0

import PackageDescription


let package = Package(
    name: "darwin-foundationplus",
	platforms: [
		.iOS(.v15),
		.watchOS(.v6),
		.macOS(.v12),
		.tvOS(.v13)
	],
    products: [
        .library(
            name: "FoundationPlus",
            targets: ["FoundationPlus"]
		),
    ],
    targets: [
        .target(
            name: "FoundationPlus",
            dependencies: [],
			path: "Sources"
		)
    ]
)
