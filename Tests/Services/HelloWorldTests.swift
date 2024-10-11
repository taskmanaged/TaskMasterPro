import XCTest
@testable import [project-name]

class HelloWorldTests: XCTestCase {
    func testHelloWorld() {
        let helloWorld = HelloWorld()
        XCTAssertEqual(helloWorld.sayHello(), "Hello, World!")
    }
}