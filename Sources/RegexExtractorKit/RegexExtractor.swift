//
//  RegexExtractor.swift
//  SwiftRegexExtractor
//
//  Created by kingcos on 2018/10/17.
//

import Foundation

public struct RegexExtractor {
    static func read(_ path: String) -> String? {
        guard let url = URL(string: path) else { return nil }
        
        let manager = FileManager.default
        guard manager.fileExists(atPath: url.path) else { return nil }
        
        guard let data = manager.contents(atPath: url.path) else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
    
    static func extractByLines(_ content: String, by pattern: String) -> [String] {
        return content.split(separator: "\n").map {
            extract(String($0), by: pattern)
        }.flatMap { $0 }
    }
    
    private static func extract(_ content: String, by pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern,
                                                   options: .caseInsensitive) else { return [] }
        let nsContent = content as NSString
        return regex.matches(in: content, options: [], range: NSRange(location: 0, length: content.count)).map {
            nsContent.substring(with: $0.range)
        }
    }
}
