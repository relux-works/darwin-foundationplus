// swift-tools-version: 5.7

import PackageDescription


let package = Package(
    name: "darwin-foundationplus",
	platforms: [
		.iOS(.v15),
		.watchOS(.v6),
		.macOS(.v10_15),
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
