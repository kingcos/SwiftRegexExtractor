//
//  RegexExtractorError.swift
//  CommandLineKit
//
//  Created by kingcos on 2018/10/22.
//

import Foundation

public enum RegexExtractorError: Error {
    // 未知错误
    case unknownError
    
    // 不支持的路径
    case unsupportedPath
    // 文件不存在
    case fileNotExist
    // 文件已存在
    case fileAlreadyExist
    // 内容为空
    case contentIsNill
}
