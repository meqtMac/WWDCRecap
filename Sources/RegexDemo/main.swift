//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/6/28.
//

import RegexBuilder

let input = "name:  John Appleseed,  user_id:  100"

let regex = Regex{
    "user_id:"
    ZeroOrMore(.whitespace)
    Capture{
        OneOrMore(.digit)
    }
}

if let match = input.firstMatch(of: regex) {
    print("Matched: \(match.0)")
    print("User ID: \(match.1)")
}

let regex2 = Regex{
    OneOrMore("a")
    OneOrMore(.digit)
}

print("wholeMatch:", input.wholeMatch(of: regex) as Any)
print("prefixMatch",input.prefixMatch(of: regex) as Any)
print("starts:", input.starts(with: regex))
print("replacing:", input.replacing(regex, with: "456"))
print("trimming:", input.trimmingPrefix(regex))

let regexSplitter = Regex{
    ZeroOrMore(.whitespace)
    ","
    ZeroOrMore(.whitespace)
}
print("split", input.split(separator:regexSplitter))

//MARK: TestSuite Example
let funcNameRegex = Regex {
    CharacterClass("a"..."z", "A"..."Z")
    ZeroOrMore{
        CharacterClass("a"..."z", "A"..."Z", "0"..."9")
    }
}

enum TestResult: String {
    case started
    case passed
    case failed
    case unknown
}

import Foundation
let testRegex = Regex{
    "Test Suite '"
    Capture(funcNameRegex)
    "' "
    
    TryCapture{
        ChoiceOf {
            "started"
            "passed"
            "failed"
        }
    } transform: {
        return TestResult(rawValue: String($0))
    }
    
    " at "
    Capture(
        .iso8601(timeZone: .current,
                 includingFractionalSeconds: true,
                 dateTimeSeparator: .space)
    )
    Optionally(".")
}

let testSuiteTestInputs = [
    "Test Suite 'RegexDSLTests' started at 2022-06-06 09:41:00.001",
    "Test Suite 'RegexDSLTests' failed at 2022-06-06 09:41:00.001.",
    "Test Suite 'RegexDSLTests' passed at 2022-06-06 09:41:00.001."
]

for line in testSuiteTestInputs {
    if let (_, name, status, date) = line.wholeMatch(of: testRegex)?.output {
        print("Matched: ", name, status, date, separator: ", ")
    }
}

//MARK: reuse an existing parser
import Darwin
struct CDoubleParser: CustomConsumingRegexComponent {
    typealias RegexOutput = Double
    func consuming(
        _ input: String,
        startingAt index: String.Index,
        in bounds: Range<String.Index>) throws -> (upperBound: String.Index, output: Double)? {
            input[index...].withCString { startAddress in
                var endAddress: UnsafeMutablePointer<CChar>!
                let output = strtod(startAddress, &endAddress)
                guard endAddress > startAddress else {return nil}
                let parsedLength = startAddress.distance(to: endAddress)
                let upperBound = input.utf8.index(index, offsetBy: parsedLength )
                return (upperBound, output)
            }
        }
}

let testCaseWithDurationInput = """
    Test Case '-[RegexDSLTests testCharacterClass]' passed (0.001 seconds).
    """

let testCaseWithDurationRegex = Regex {
    "Test Case "; OneOrMore(.any, .reluctant); "("
    Capture ( CDoubleParser() )
    " seconds)."
}

if let match = testCaseWithDurationInput.wholeMatch(of: testCaseWithDurationRegex) {
    print("Time: \(match.1)")
}
