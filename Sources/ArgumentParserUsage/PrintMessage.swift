import Foundation
import ArgumentParser

public struct PrintMessage: ParsableCommand {
    
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
    var console: ((String) -> Void) = {
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
