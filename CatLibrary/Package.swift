// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CatLibrary",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        InnerDependencies.Extensions.library,
        InnerDependencies.Dependencies.library,
        InnerDependencies.Models.library,
        .library(name: "CatCore", targets: ["CatCore"]),
    ],
    dependencies: OuterDependencies.allCases.map(\.package),
    targets: [
        .target(name: "Extensions"),
        .target(name: "Models"),
        .target(
            name: "Dependencies", 
            dependencies: [
                OuterDependencies.SwiftFP.target
            ]),
        .target(
            name: "CatCore",
            dependencies: [
                InnerDependencies.Extensions.target
            ]),
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
    case Kingfisher
    
    var package: Package.Dependency {
        switch self {
        case .SwiftUDF: return .package(url: "https://github.com/ShapovalovIlya/SwiftUDF.git", branch: "main")
        case .SwiftFP: return .package(url: "https://github.com/ShapovalovIlya/SwiftFP.git", branch: "main")
        case .Kingfisher: return .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.9.1")
        }
    }
    
    var target: Target.Dependency {
        switch self {
        case .SwiftUDF: return .product(name: "SwiftUDF", package: "SwiftUDF")
        case .SwiftFP: return .product(name: "SwiftFP", package: "SwiftFP")
        case .Kingfisher: return .product(name: "Kingfisher", package: "Kingfisher")
        }
    }
}
