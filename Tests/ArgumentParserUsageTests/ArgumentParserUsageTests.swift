import XCTest
@testable import ArgumentParserUsage

final class ArgumentParserUsageTests: XCTestCase {
    
    func testNoPrefix() throws {
        let runner = try PrintMessage.parse(["Test Message", "--skip-prefix"]) {
            XCTAssertEqual($0, "Test Message", "Invalid message option")
        }
        try runner.run()
    }
    
    func testDefaultPrefix() throws {
        let runner = try PrintMessage.parse(["Test Message"]) {
            XCTAssertEqual($0, "Message: Test Message", "Invalid message option")
        }
        try runner.run()
    }
    
    func testCustomPrefix() throws {
        let runner = try PrintMessage.parse(["Test Message", "--prefix", "Another prefix: "]) {
            XCTAssertEqual($0, "Another prefix: Test Message", "Invalid message option")
        }
        try runner.run()
    }
    
    func testSkipCustomPrefix() throws {
        let runner = try PrintMessage.parse(["Test Message", "--prefix", "Another prefix: ", "--skip-prefix"]) {
            XCTAssertEqual($0, "Test Message", "Invalid message option")
        }
        try runner.run()
    }

    func testNoArgumentException() throws {
        XCTAssertThrowsError(try PrintMessage.parse([]))
    }
    
    func testEmptyMessage() throws {
        let runner = try PrintMessage.parse([""]) { _ in
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
