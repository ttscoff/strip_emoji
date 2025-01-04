import XCTest

@testable import strip_emoji

class StripEmojiTests: XCTestCase {
    func testStripEmoji() {
        XCTAssertEqual("Hello 🌍".stripEmoji(), "Hello ")
        XCTAssertEqual("👩‍👩‍👧‍👦 fun🤝🏽".stripEmoji().trimmingCharacters(in: .whitespaces), "fun")
        XCTAssertEqual("👩‍👩‍👧‍👦⛲️🀄️".stripEmoji(), "")
        XCTAssertEqual("No emoji here!".stripEmoji(), "No emoji here!")
        XCTAssertEqual("Multiple emojis 🤔🤔🤔".stripEmoji(), "Multiple emojis ")
        XCTAssertEqual("Mixed content 🎉 with text".stripEmoji(), "Mixed content  with text")
    }
}

func runTests() {
    // Run the tests
    StripEmojiTests.defaultTestSuite.run()
}
