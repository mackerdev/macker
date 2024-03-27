import ArgumentParser

public struct PullCommand: AsyncParsableCommand {
    public static var configuration: CommandConfiguration = .init(
        commandName: "pull",
        abstract: "Pulls an image from the registry"
    )

    public init() {}

    public func run() async throws {}
}
