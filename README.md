# ArgumentParser Unit Test Sample

This project demonstrate how a struct that conforms to `ParsableCommand` can be unit tested with the support of the `.parse(_:[String])` method, an output variable and `CodingKeys`.

The goal is to demonstrate a code pattern that allows to code injection and an unit test simiar to:

```swift
func testDefaultPrefix() throws {
    let runner = try PrintMessage.parse(["Test Message"]) {
        XCTAssertEqual($0, "Message: Test Message", "Invalid message option")
    }
    try runner.run()
}
```
