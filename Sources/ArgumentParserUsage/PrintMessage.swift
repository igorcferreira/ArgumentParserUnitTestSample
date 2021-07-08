import Foundation
import ArgumentParser

public struct PrintMessage: ParsableCommand {
    
    public static let configuration = CommandConfiguration(abstract: "Prints a message with an optional prefix")
    
    /// The `CodingKeys` is necessary to remove the `console` variable from the Decodable
    /// parsing.
    enum CodingKeys: String, CodingKey {
        case message
        case skipPrefix
        case prefix
    }
    
    @Flag(help: "Used to skip the prefix")
    var skipPrefix = false
    
    @Option(name: .shortAndLong, help: "Prefix to be used in the message")
    var prefix: String?
    
    @Argument(help: "The text to print")
    var message: String
    
    /// This `console` variable is used to allow unit testing the output of the process.
    private var console: ((String) -> Void) = {
        print($0)
    }
    
    public init() {}
    
    public func run() throws {
        
        guard !message.isEmpty else { throw PrintError.emptyMessage }
        
        if skipPrefix {
            console(message)
        } else {
            console("\(prefix ?? "Message: ")\(message)")
        }
    }
}

#if DEBUG
public extension PrintMessage {
    static func parse(_ arguments: [String], console: @escaping (String) -> Void) throws -> Self {
        var object = try Self.parse(arguments)
        object.console = console
        return object
    }
}
#endif
