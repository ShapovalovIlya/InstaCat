// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CatLibrary",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        InnerDependencies.Extensions.library,
        InnerDependencies.Dependencies.library,
        InnerDependencies.Models.library,
        .library(name: "CatCore", targets: ["CatCore"]),
        .library(name: "RootDomain", targets: ["RootDomain"]),
        .library(name: "SideBarDomain", targets: ["SideBarDomain"]),
        .library(name: "ContentDomain", targets: ["ContentDomain"]),
        .library(name: "GalleriaDomain", targets: ["GalleriaDomain"]),
 //       .library(name: "ImageDownloader", targets: ["ImageDownloader"]),
    ],
    dependencies: OuterDependencies.allCases.map(\.package),
    targets: [
        .target(name: "Extensions"),
        .target(name: "Models"),
        .target(
            name: "Dependencies", 
            dependencies: [
                OuterDependencies.SwiftFP.target,
                InnerDependencies.Extensions.target,
            ]),
        .target(
            name: "CatCore",
            dependencies: [
                InnerDependencies.Extensions.target,
                "RootDomain",
            ]),
        .target(
            name: "RootDomain",
            dependencies: [
                InnerDependencies.Extensions.target,
                InnerDependencies.Dependencies.target,
                InnerDependencies.Models.target,
                OuterDependencies.SwiftUDF.target,
                "SideBarDomain",
                "ContentDomain",
            ]),
        .target(
            name: "SideBarDomain",
            dependencies: [
                InnerDependencies.Extensions.target,
                InnerDependencies.Models.target,
                InnerDependencies.Dependencies.target,
                OuterDependencies.SwiftUDF.target,
            ]),
        .target(
            name: "ContentDomain",
            dependencies: [
                InnerDependencies.Extensions.target,
                InnerDependencies.Models.target,
                InnerDependencies.Dependencies.target,
                OuterDependencies.SwiftUDF.target,
                "GalleriaDomain"
            ]),
        .target(
            name: "GalleriaDomain",
            dependencies: [
                InnerDependencies.Extensions.target,
                InnerDependencies.Models.target,
                InnerDependencies.Dependencies.target,
                OuterDependencies.SwiftUDF.target,
                OuterDependencies.ImageDownloader.target,
       //         "ImageDownloader"
            ]),
   //     .target(name: "ImageDownloader"),
        .testTarget(
            name: "AppTests",
            dependencies: [
                InnerDependencies.Extensions.target,
                InnerDependencies.Models.target,
                OuterDependencies.SwiftUDF.target,
                "RootDomain",
                "SideBarDomain",
                "ContentDomain",
                "GalleriaDomain",
            ])
    ]
)

//MARK: - InnerDependencies
fileprivate enum InnerDependencies {
    case Extensions
    case Dependencies
    case Models
    
    var library: Product {
        switch self {
        case .Extensions: .library(name: "Extensions", targets: ["Extensions"])
        case .Dependencies: .library(name: "Dependencies", targets: ["Dependencies"])
        case .Models: .library(name: "Models", targets: ["Models"])
        }
    }
    
    var target: Target.Dependency {
        switch self {
        case .Extensions: return "Extensions"
        case .Dependencies: return "Dependencies"
        case .Models: return "Models"
        }
    }
}

//MARK: - OuterDependencies
fileprivate enum OuterDependencies: CaseIterable {
    case SwiftUDF
    case SwiftFP
    case ImageDownloader
    
    var package: Package.Dependency {
        switch self {
        case .SwiftUDF: return .package(url: "https://github.com/ShapovalovIlya/SwiftUDF.git", branch: "main")
        case .SwiftFP: return .package(url: "https://github.com/ShapovalovIlya/SwiftFP.git", branch: "main")
        case .ImageDownloader: return .package(url: "https://github.com/ShapovalovIlya/ImageDownloader.git", branch: "main")
        }
    }
    
    var target: Target.Dependency {
        switch self {
        case .SwiftUDF: return .product(name: "SwiftUDF", package: "SwiftUDF")
        case .SwiftFP: return .product(name: "SwiftFP", package: "SwiftFP")
        case .ImageDownloader: return .product(name: "ImageDownloader", package: "ImageDownloader")
        }
    }
}
