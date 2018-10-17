import XCTest
import class Foundation.Bundle

final class SwiftRegexExtractorTests: XCTestCase {
    func testSwiftRegexExtractorBySpectre() {
        testSwiftRegexExtractor()
    }

    static var allTests = [
        ("test by Spectre", testSwiftRegexExtractor)
    ]
}
