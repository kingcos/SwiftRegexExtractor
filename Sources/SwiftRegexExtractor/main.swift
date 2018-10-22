//
//  main.swift
//  SwiftRegexExtractor
//
//  Created by kingcos on 2018/10/17.
//

import Foundation

import RegexExtractorKit
import CommandLineKit

let version = "SwiftRegexExtractor by github.com/kingcos: v0.1.0"
let cli = CommandLineKit.CommandLine()

let inputFilePathOption = StringOption(shortFlag: "i",
                                       longFlag: "input",
                                       helpMessage: "Setup file path for input.")
let outputFilePathOption = StringOption(shortFlag: "o",
                                        longFlag: "output",
                                        helpMessage: "Setup file path for output (Default is command line interface).")
let regexOption = StringOption(shortFlag: "r",
                               longFlag: "regex",
                               helpMessage: "Regular expression.")
let helpOption = BoolOption(shortFlag: "h",
                            longFlag: "help",
                            helpMessage: "Print help info.")
let versionOption = BoolOption(shortFlag: "v",
                               longFlag: "version",
                               helpMessage: "Print version info.")

cli.addOptions(inputFilePathOption,
               outputFilePathOption,
               regexOption,
               helpOption,
               versionOption)

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if helpOption.value {
    cli.printUsage()
    exit(EX_OK)
}

if versionOption.value {
    print(version)
    exit(EX_OK)
}

guard let inputFilePath = inputFilePathOption.value,
      let outputFilePath = outputFilePathOption.value,
      let regex = regexOption.value else {
        cli.printUsage()
        exit(EX_OK)
}

do {
    try RegexExtractor.run(inputFilePath, outputFilePath, regex)
} catch {
    guard let err = error as? RegexExtractorError else {
        print("ERROR: \(error.localizedDescription).")
        exit(EX_USAGE)
    }
    
    switch err {
    default:
        print("ERROR")
    }
}
