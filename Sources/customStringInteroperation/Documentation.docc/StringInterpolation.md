# StringInterpolation

Super-powered string interpolation in Swift 5.0
@Metadata {
    @CallToAction(
                  purpose: link, 
                  url: "https://www.hackingwithswift.com/articles/178/super-powered-string-interpolation-in-swift-5-0")
}

## Overview 
The following examples show how string interpolations are translated into calls to appendInterpolation:
- `\(x)` translates to `appendInterpolation(x)`
- `\(x, y)` translates to `appendInterpolation(x, y)`
- `\(foo: x)` translates to `appendInterpolation(foo: x)`
- `\(x, foo: y)` translates to `appendInterpolation(x, foo: y)`

implementation 
```swift
extension MyString.StringInterpolation {
    mutating func appendInterpolation(validating input: String) {
        // Perform validation of `input` and store for later use
    }
}
let userInput = readLine() ?? ""
let myString = "The user typed '\(validating: userInput)'." as MyString
```

### See Also 

- ``String.StringInterpolationProtocol``
- ``DefaultStringInterpolation``

