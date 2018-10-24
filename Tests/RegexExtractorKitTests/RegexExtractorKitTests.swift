import XCTest
import class Foundation.Bundle

import PathKit
import Spectre

@testable import RegexExtractorKit

class RegexExtractorKitTests: XCTestCase {
    static var allTests = [
        ("test by Spectre", testRegexExtractorKitBySpectre)
    ]
    
    func testRegexExtractorKitBySpectre() {
        let currentPath = Path(#file).parent().parent() + "Attachments"
        let exampleContent = """
Pull requests
Issues
Marketplace
Explore
 @kingcos
@kingcos    kingcos

kingcos
kingcos
Code with passion. Live with love.
 Edit bio
Developer Program Member
@Mobike-iOS
Beijing kingcosv@hotmail.com https://github.com/kingcos/Perspective
Organizations
@iMana-Platform   @iV2EX   @NYIST-OS   @Hack-Time   @Mobike-iOS @Poword
Overview
Repositories 40
Stars 501
Followers 107
Following 194
Customize your pinned repositories
Pinned repositories

Perspective
📝 Write something with perspectives.

 Swift   42    4
WWDCHelper
⏬ Help you get WWDC info easily, especially for subtitles.

 Swift   125    8
Swift-X-Design-Patterns
✏️ Design patterns implemented in Swift X. `let x = 4.2`

 Swift   85    22
MyBatisGenerator-Tool
🔧 A tool which aims to generate code by using MyBatis Generator with Gradle in IntelliJ IDEA.

 Java   14    11
fluwer
🌼 A simple app for easily distributing apps, downloading packages, and tracking issues.

 Dart   1
gitlab-mr-jira-issue-trigger
🚀 A GitLab webhook to trigger Jira issue transition when merge request events occurred.

 Go
Contribution settings
987 contributions in the last year

Oct
Nov
Dec
Jan
Feb
Mar
Apr
May
Jun
Jul
Aug
Sep
Oct
Mon
Wed
Fri
Learn how we count contributions. Less      More
2018
2017
2016
2015
2014
Contribution activity
Jump to

October 2018
 Created 59 commits in 9 repositories
 Created 1 repository
 kingcos/SwiftRegexExtractor   Swift Oct 17
 Opened 2 pull requests in 2 repositories

kingcos/WWDCHelper
1 merged

kingcos/Swift-X-Design-Patterns
1 merged
 Opened 1 issue in 1 repository

kingcos/Perspective
1 open
 谈谈 iOS 中的 `dyld_shared_cache` Oct 17
Show more activity
Seeing something unexpected? Take a look at the GitHub profile guide.

© 2018 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
Press h to open a hovercard with more details.
"""
        
        describe("--- SwiftRegexExtractor Tests ---") {
            
            $0.it("should extract from content by regex") {
                let emojiPattern1 = "[\\p{Emoji_Presentation}\\u26F1]"
                let emojiPattern2 = "\\p{Emoji}\\uFE0F"
                let emojiPattern3 = "\\p{Emoji_Modifier_Base}\\p{Emoji_Modifier}"
                let emojiPattern4 = "[\\U0001F1E6-\\U0001F1FF][\\U0001F1E6-\\U0001F1FF]"
                let pattern = "\(emojiPattern4)|\(emojiPattern3)|\(emojiPattern2)|\(emojiPattern1)"
                
                try expect(RegexExtractor.extractByLines(exampleContent, by: pattern)) == ["📝", "⏬", "✏️", "🔧", "🌼", "🚀"]
            }
            
            $0.it("should write content to file, then read content from path") {
                let outputFileName = "DemoFile.txt"
                let path = (currentPath + outputFileName).description

                do {
                    try RegexExtractor.write(exampleContent, to: path)

                    guard let content = RegexExtractor.read(path) else {
                        XCTFail()
                        return
                    }

                    try expect(content) == exampleContent
                } catch {
                    switch error {
                    case RegexExtractorError.fileAlreadyExist:
                        print("ERROR: File is already exist.")
                    case RegexExtractorError.unsupportedPath:
                        print("ERROR: Unsupported path.")
                    default:
                        print("ERROR: \(error.localizedDescription).")
                    }
                    XCTFail()
                }
            }
        }
    }
}
