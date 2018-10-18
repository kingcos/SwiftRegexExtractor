import XCTest
//import class Foundation.Bundle

import PathKit
import Spectre

@testable import RegexExtractorKit

class SwiftRegexExtractorTests: XCTestCase {
    static var allTests = [
        ("test by Spectre", testSwiftRegexExtractorBySpectre)
    ]
    
    func testSwiftRegexExtractorBySpectre() {
        
        let currentPath = Path(#file).parent().parent() + "Attachments"
        
        describe("--- SwiftRegexExtractor Tests ---") {

            let extractor = RegexExtractor.shared

            $0.it("should read content from path") {
                let regex = "^([A-Z]{2})$"
                let inputFilename = "InputFile.txt"
                let path = currentPath + inputFilename

                //            extractor

                try expect(true) == true

            }
        }
    }

    
}
