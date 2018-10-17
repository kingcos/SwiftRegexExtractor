//
//  RegexExtractor.swift
//  SwiftRegexExtractor
//
//  Created by kingcos on 2018/10/17.
//

import Foundation

public class RegexExtractor {
    var regularExpressions: [String]
    var inputFilePaths: [String]
    var outputFilePaths: [String]
    
    static let shared = RegexExtractor()
    
    private init() {
        self.regularExpressions = []
        self.inputFilePaths = []
        self.outputFilePaths = []
    }
    
    func read(_ path: String) -> String? {
        guard let url = URL(string: path) else { return nil }
        
        let manager = FileManager.default
        guard manager.fileExists(atPath: url.path) else { return nil }
        
        guard let data = manager.contents(atPath: url.path) else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
}
