import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "macker", targets: Module.allCases.map({ module in
        .target(
            name: module.name,
            destinations: Set(arrayLiteral: module.destination),
            product: module.product,
            bundleId: module.bundleId,
            sources: module.sources,
            dependencies: module.dependencies
        )
    }))
