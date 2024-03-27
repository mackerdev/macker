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
        return .mac
    }
    
    public var dependencies: [TargetDependency] {
        switch self {
        case .macker: return [
            .target(name: Module.pull.name),
            .target(name: Module.run.name)
        ]
        case .pull: return []
        case .run: return []
        }
    }
    
    public var bundleId: String {
        "io.tuist.\(name)"
    }
    
    public var sources: SourceFilesList {
        [
            "Sources/\(name)/**/*.swift"
        ]
    }
}
