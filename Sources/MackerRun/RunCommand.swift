import ArgumentParser

public struct RunCommand: AsyncParsableCommand {
    public static var configuration: CommandConfiguration = .init(
        commandName: "run",
        abstract: "Runs an image"
    )

    public init() {}

    @Argument(help: "The phrase to repeat.")
    public var image: String

    public func run() async throws {}
}
