//
//  RegexExtractor.swift
//  SwiftRegexExtractor
//
//  Created by kingcos on 2018/10/17.
//

import Foundation

public struct RegexExtractor {
    private static func isFileExist(_ path: String) throws -> URL? {
        guard let url = URL(string: path) else {
            throw RegexExtractorError.unsupportedPath
        }
        if !FileManager.default.fileExists(atPath: url.path) {
            return nil
        }
        
        return url
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

extension RegexExtractor {
    public static func run(_ inputFilePath: String,
                           _ outputFilePath: String,
                           _ regex: String) throws {
        guard let inputContent = read(inputFilePath) else {
            throw RegexExtractorError.contentIsNill
        }
        
        let outputContent = extractByLines(inputContent, by: regex).reduce("") { $0 + "\n" + $1 }
        
        do {
            try write(outputContent, to: outputFilePath)
        } catch {
            guard let error = error as? RegexExtractorError else {
                throw RegexExtractorError.unknownError
            }
            throw error
        }
    }
    
    public static func read(_ path: String) -> String? {
        do {
            guard let url = try isFileExist(path),
                  let data = FileManager.default.contents(atPath: url.path) else { return nil }
            
            return String(data: data, encoding: .utf8)
        } catch {
            switch error {
            case RegexExtractorError.unsupportedPath:
                print("ERROR: Unsupported path.")
            default:
                print("ERROR: Unknown error.")
            }
        }
        
        return nil
    }
    
    public static func write(_ content: String, to path: String) throws {
        do {
            if let _ = try isFileExist(path) {
                throw RegexExtractorError.fileAlreadyExist
            } else {
                if let url = URL(string: "file://" + path) {
                    try content.write(to: url, atomically: true, encoding: .utf8)
                } else {
                    throw RegexExtractorError.unsupportedPath
                }
            }
        } catch {
            switch error {
            case RegexExtractorError.fileAlreadyExist:
                print("ERROR: File is already exist.")
            case RegexExtractorError.unsupportedPath:
                print("ERROR: Unsupported path.")
            default:
                print("ERROR: \(error.localizedDescription).")
            }
        }
    }
    
    public static func extractByLines(_ content: String, by pattern: String) -> [String] {
        return content.split(separator: "\n").map {
            extract(String($0), by: pattern)
            }.flatMap { $0 }
    }
}
