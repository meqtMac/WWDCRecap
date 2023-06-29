# Regex Demo

This is a recap of WWDC's Swift 

@Metadata {
    @CallToAction(
       purpose: link,
       url: "https://developer.apple.com/wwdc22/110357")
}

## Overview
- [Meet Swift Regex](https://developer.apple.com/wwdc22/110357)
- [Swift Regex: Beyond the basics](https://developer.apple.com/wwdc22/110358)

### Topics

#### Regex and Regex Builder
Regex is `Swift Standard Library` build in Type.
@Row {
    @Column{
    
    
    ```swift
    import RegexBuilder
    // Regex Builder
    Regex {
        "Hi, WWDC"
        Repeat(.digit, count: 2)
        "!"
    }
    ```
    }
    
    @Column {
        ```swift
        // regex literial
        let regex = /user_id:\s*(\d+)/
        // Regex
        let regex2 = try Regex(#"user_id:\s*(\d+)"#)
        ```
    }
}

@TabNavigator {
    @Tab("Regex Builder") {
        ```swift
        import RegexBuilder
        // Regex Builder
        Regex {
            "Hi, WWDC"
            Repeat(.digit, count: 2)
            "!"
        }
        ```
    }
        
    @Tab("Regex Literial")  {
        ```swift
        // regex literial
        let regex = /user_id:\s*(\d+)/
        ```
    }
        
    @Tab("From String") {
        ```swift
        // Regex
        let regex2 = try Regex(#"user_id:\s*(\d+)"#)
        ```
    }
}

### Match
- `firstMatch`
- `wholeMatch`
- `prefixMatch`
- `start(with: )`
- `replacing(regex, with: )`
- `trimmingPrefix()`
- `split(separator: Regex)`
- `switch case Regex: `

Demo
```swift
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
print("wholeMatch:", input.wholeMatch(of: regex))
print("prefixMatch",input.prefixMatch(of: regex))
print("starts:", input.starts(with: regex))
print("replacing:", input.replacing(regex, with: "456"))
print("trimming:", input.trimmingPrefix(regex))

let regexSplitter = Regex{
    ZeroOrMore(.whitespace)
    ","
    ZeroOrMore(.whitespace)
}
print("split", input.split(separator:regexSplitter))
```
Result
```txt
Matched: user_id:  100
User ID: 100
wholeMatch: nil
prefixMatch nil
starts: false
replacing: name:  John Appleseed,  456
trimming: name:  John Appleseed,  user_id:  100
split ["name:  John Appleseed", "user_id:  100"]
```

### Regex support in Foundation
Inorder to use Foundation's default parser, you need to include `Foundation`
```swift
import Foundation
import RegexBuilder
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
```

### Reuse an existing parser
`strtod` C function
```swift
//MARK: reuse an existing parser
import Darwin
import RegexBuilder
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

let testCaseWithDurationInput = "Test Case '-[RegexDSLTests testCharacterClass]' passed (0.001 seconds)."

let testCaseWithDurationRegex = Regex {
    "Test Case "
    OneOrMore(.any, .reluctant)
    "("
    Capture {
        CDoubleParser()
    }
    " seconds)."
}



if let match = testCaseWithDurationInput.wholeMatch(of: testCaseWithDurationRegex) {
    print("Time: \(match.1)")
}
// Time: 0.001 
```

