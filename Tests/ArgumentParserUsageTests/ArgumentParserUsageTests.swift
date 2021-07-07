import XCTest
@testable import ArgumentParserUsage

final class ArgumentParserUsageTests: XCTestCase {
    
    func testNoPrefix() throws {
        var runner = try PrintMessage.parse(["Test Message", "--skip-prefix"])
        runner.console = {
            XCTAssertEqual($0, "Test Message", "Invalid message option")
        }
        try runner.run()
    }
    
    func testDefaultPrefix() throws {
        var runner = try PrintMessage.parse(["Test Message"])
        runner.console = {
            XCTAssertEqual($0, "Message: Test Message", "Invalid message option")
        }
        try runner.run()
    }
    
    func testCustomPrefix() throws {
        var runner = try PrintMessage.parse(["Test Message", "--prefix", "Another prefix: "])
        runner.console = {
            XCTAssertEqual($0, "Another prefix: Test Message", "Invalid message option")
        }
        try runner.run()
    }
    
    func testSkipCustomPrefix() throws {
        var runner = try PrintMessage.parse(["Test Message", "--prefix", "Another prefix: ", "--skip-prefix"])
        runner.console = {
            XCTAssertEqual($0, "Test Message", "Invalid message option")
        }
        try runner.run()
    }

    func testNoArgumentException() throws {
        XCTAssertThrowsError(try PrintMessage.parse([]))
    }
    
    func testEmptyMessage() throws {
        var runner = try PrintMessage.parse([""])
        runner.console = { _ in
            XCTFail("No message should be displayed")
        }
        XCTAssertThrowsError(try runner.run())
    }
    
    static var allTests = [
        ("testNoPrefix", testNoPrefix),
        ("testDefaultPrefix", testDefaultPrefix),
        ("testCustomPrefix", testCustomPrefix),
        ("testNoArgumentException", testNoArgumentException)
    ]
}
