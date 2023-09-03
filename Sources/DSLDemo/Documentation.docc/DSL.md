# DSL in swift

@Metadata {
    @CallToAction(
                  purpose: link,
                  url: "https://developer.apple.com/wwdc21/10253")
}

## Overview
embedded DSL features

DSL for non professional programmers.

language have a learning curve.

### SwiftUI DSL
- `Property wrappers`
- `Trailing closure arguments`
- `Result builders`
- `Modifier-style methods`

#### Result Builders
Swift 5.4
Compile-time feature
```swift
VStack {
    Text("Title").font(.title)
    Text("Contents")
}

struct VStack<Content: View>: View {
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

@resultBuilder enum ViewBuilder {
    static func buildBlock(_: View...) -> some View { ... }
}
```

```swift
VStack.init(content: {
    let v0 = Text("Title").font(.title).foregroundColor(.green)
    let v1 = Text("Contents")
    return ViewBuilder.buildBlock(v0, v1)
})
```
Powerful feature vs. Predictable behavior

Result Builders disable some language keywords.

## Designing a DSL
DSL are like APIs, only more so

Decide how to express ideas in Swift
Deicisons are subjective.
Aim for clarity at the point of use.
Skill transfer in both directions


### Improve Error Behavior
```swift
// SmoothieBuilder without the string

Smoothie(…) /* @SmoothieBuilder */ {
    // "Filling and refreshing, this smoothie will fill you with joy!"
    /* let v0 = */ Ingredient.orange.measured(with: .cups).scaled(by: 1.5)
    /* let v1 = */ Ingredient.blueberry.measured(with: .cups)
    /* let v2 = */ Ingredient.avocado.measured(with: .cups).scaled(by: 0.2)
    
    /* return SmoothieBuilder.buildBlock(v0, v1, v2) */
}

extension SmoothieBuilder {
    static func buildBlock(_ description: String, _ ingredients: ManagedIngredients...)
        -> (String, [ManagedIngredients]) { … }

    @available(*, unavailable, message: "missing ‘description’ field")
    static func buildBlock(_ ingredients: ManagedIngredients...)
        -> (String, [ManagedIngredients]) { fatalError() }
}
```
