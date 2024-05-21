import ProjectDescription

public enum Module: CaseIterable {
    case macker
    case pull
    case run

    public var name: String {
        switch self {
        case .macker: "macker"
        case .pull: "MackerPull"
        case .run: "MackerRun"
        }
    }

    public var product: Product {
        switch self {
        case .macker:
            return .commandLineTool
        case .pull, .run:
            return .staticLibrary
        }
    }

    public var destination: Destination {
        .mac
    }

    public var dependencies: [TargetDependency] {
        switch self {
        case .macker: return [
                .target(name: Module.pull.name),
                .target(name: Module.run.name),
                .external(name: "ArgumentParser"),
            ]
        case .pull: return [
                .external(name: "ArgumentParser"),
            ]
        case .run: return [
                .external(name: "ArgumentParser"),
            ]
        }
    }

    public var bundleId: String {
        "io.tuist.\(name)"
    }

    public var sources: SourceFilesList {
        [
            "Sources/\(name)/**/*.swift",
        ]
    }

    var hasTests: Bool {
        switch self {
        case .macker:
            return false
        case .pull, .run:
            return true
        }
    }

    public var targets: [Target] {
        var targets: [Target] = [
            .target(
                name: name,
                destinations: Set(arrayLiteral: destination),
                product: product,
                bundleId: bundleId,
                deploymentTargets: .macOS("13.0.0"),
                sources: sources,
                dependencies: dependencies + [.external(name: "Mockable")],
                settings: .settings(configurations: [
                    // This is important to exclude the mock implementations from release builds
                    .debug(name: .debug, settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) MOCKING"]),
                    .release(name: .release, settings: [:]),
                ])
            ),
        ]

        if hasTests {
            targets.append(.target(
                name: "\(name)Tests",
                destinations: Set(arrayLiteral: destination),
                product: .unitTests,
                bundleId: bundleId,
                deploymentTargets: .macOS("13.0.0"),
                sources: sources,
                dependencies: dependencies + [.xctest, .target(name: name), .external(name: "MockableTest")]
            ))
        }
        return targets
    }
}
