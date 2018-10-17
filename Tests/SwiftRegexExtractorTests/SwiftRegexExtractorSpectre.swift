//
//  SwiftRegexExtractorSpectre.swift
//  SwiftRegexExtractor
//
//  Created by kingcos on 2018/10/17.
//

import Foundation
import XCTest

import PathKit
import Spectre

@testable import SwiftRegexExtractor

public func testSwiftRegexExtractor() {
    
    let currentPath = Path(#file).parent().parent() + "Attachments"
    
    describe("--- SwiftRegexExtractor Tests ---") {
        
        let extractor = RegexExtractor.shared
        
        $0.it("should read content from path") {
            let regex = "^([A-Z]{2})$"
            let inputFilename = "InputFile.txt"
            let path = currentPath + inputFilename
            
//            extractor
            
            
            
        }
    }
}
