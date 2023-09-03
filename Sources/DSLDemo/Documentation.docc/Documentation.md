# DSL in Swift

@Metadata {
    @CallToAction(
                  purpose: link,
                  url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes#resultBuilder")
}


## Property Wrappers

## Trailing closure arguments

## Result Builders
-- Compile time feature Swift 5.4, so it works on any platform( which swift support)

Applied to a 
- function
- method
- getter
- closure

Wrap statements in implict methods c
```swift
VStack {
Text("Title")
.font(.title)
Text("Contents")
}

struct VStack<Content>: View where Content: View {
init(@ViewBuilder content: () -> Content) {
self.content = content()
}
}
```

```swift
VStack.init(content: {
let v0 = Text("Title").font(.title)
let v1 = Text("Contents")
return ViewBuilder.buildBlock(v0, v1)
})

modifiers change the result before result builder sees it.
```

Powerful feature and Predicatable results

Result builders disable soem language keywords.
- Some are enabled conditionally

DSLs are like APIs, only more so
- Decide how to express ideas in Swift
- Decisions are subjective
- clarity
- Skills transfer in both directions


## Modifier-style methods

### Possible DSL description/ingredient designs
@TabNavigator {
    @Tab("start") {
        ```swift
        // Possible DSL description/ingredient designs
        
        Smoothie(
        id: "berry-blue",
        title: "Berry Blue",
        description: "Filling and refreshing, this smoothie will fill you with joy!",
        measuredIngredients: [
        Ingredient.orange.measured(with: .cups).scaled(by: 1.5),
        Ingredient.blueberry.measured(with: .cups),
        Ingredient.avocado.measured(with: .cups).scaled(by: 0.2)
        ]
        )
        ```
    }
    
    @Tab("modifiers")  {
        ```swift
        / Possible DSL description/ingredient designs
        
        Smoothie(id: "berry-blue", title: "Berry Blue")
        .description("Filling and refreshing, this smoothie will fill you with joy!")
        .ingredient(Ingredient.orange.measured(with: .cups).scaled(by: 1.5))
        .ingredient(Ingredient.blueberry.measured(with: .cups))
        .ingredient(Ingredient.avocado.measured(with: .cups).scaled(by: 0.2))
        ```
    }
    
    @Tab("all marker types") {
        ```swift
        // Possible DSL description/ingredient designs
        
        Smoothie {
        ID("berry-blue")
        Title("Berry Blue")
        Description("Filling and refreshing, this smoothie will fill you with joy!")
        
        Recipe(
        Ingredient.orange.measured(with: .cups).scaled(by: 1.5),
        Ingredient.blueberry.measured(with: .cups),
        Ingredient.avocado.measured(with: .cups).scaled(by: 0.2)
        )
        }
        ```
    }
    
    @Tab("some marker types") {
        ```swift
        / Possible DSL description/ingredient designs
        
        Smoothie(id: "berry-blue", title: "Berry Blue") {
        Description("Filling and refreshing, this smoothie will fill you with joy!")
        
        Recipe(
        Ingredient.orange.measured(with: .cups).scaled(by: 1.5),
        Ingredient.blueberry.measured(with: .cups),
        Ingredient.avocado.measured(with: .cups).scaled(by: 0.2)
        )
        }
        ```
    }
    @Tab("no marker types") {
        ```swift
        // Possible DSL description/ingredient designs
        
        Smoothie(id: "berry-blue", title: "Berry Blue") {
        "Filling and refreshing, this smoothie will fill you with joy!"
        
        Ingredient.orange.measured(with: .cups).scaled(by: 1.5)
        Ingredient.blueberry.measured(with: .cups)
        Ingredient.avocado.measured(with: .cups).scaled(by: 0.2)
        }
        ```
    }
    @Tab("Final DSL design") {
        ```swift
        // DSL top-level design
        
        @SmoothieArrayBuilder
        static func all(includingPaid: Bool = true) -> [Smoothie] {
        Smoothie(id: "berry-blue", title: "Berry Blue") {
        "Filling and refreshing, this smoothie will fill you with joy!"
        
        Ingredient.orange.measured(with: .cups).scaled(by: 1.5)
        Ingredient.blueberry.measured(with: .cups)
        Ingredient.avocado.measured(with: .cups).scaled(by: 0.2)
        }
        
        Smoothie(…) { … }
        
        if includingPaid {
        Smoothie(…) { … }
        } else {
        logger.log("Free smoothies only")
        }
        } 
        ```
    }
}


### Language design tips
- Start with goals
- Look for precedents and inspirations
- Think about fit with the whole
- Try to define away mistakes
= Evaluate many possibilities
- Pick the one you think best

## Write some DSL

## How `resultBuilder` work

### buildBlock
```swift
// How ‘buildBlock(…)’ works

@SmoothieArrayBuilder
static func all(includingPaid: Bool = true) {
/* let v0 = */ Smoothie(id: "berry-blue", title: "Berry Blue") { … }

/* let v1 = */ Smoothie(id: "carrot-chops", title: "Carrot Chops") { … }

// …more smoothies…

/* return SmoothieArrayBuilder.buildBlock(v0, v1, …) */
}
```

### `if` statements work wiht buildOptional(_:)
```swift
// How ‘if’ statements work with ‘buildOptional(_:)’

@SmoothieArrayBuilder
static func all(includingPaid: Bool = true) {
/* let v0 = */ Smoothie(id: "berry-blue", …) { … }
/* let v1 = */ Smoothie(id: "carrot-chops", …) { … }

/* let v2: [Smoothie] */
if includingPaid {
/* let v2_0 = */ Smoothie(id: "crazy-colada", …) { … }
/* let v2_1 = */ Smoothie(id: "hulking-lemonade", …) { … }
/* let v2_block = SmoothieArrayBuilder.buildBlock(v2_0, v2_1)
v2 = SmoothieArrayBuilder.buildOptional(v2_block) */
}
/* else {
v2 = SmoothieArrayBuilder.buildOptional(nil)
} */

/* return SmoothieArrayBuilder.buildBlock(v0, v1, v2) */
}
```

### buildExpression
for example above:
translate `Smoothie` to `[Smoothie]` and edit `buildBlock` to accept `[Smoothie]` as input.

### buildEither(first:) buildEither(second:)
```swift
// How ‘if’-‘else’ statements work with ‘buildEither(…)’

@SmoothieArrayBuilder
static func all(includingPaid: Bool = true) -> [Smoothie] {
/* let v0: [Smoothie] */
if includingPaid {
/* let v0_0 = SmoothieArrayBuilder.buildExpression( */ Smoothie(…) { … } /* ) */
/* let v0_block = SmoothieArrayBuilder.buildBlock(v0_0)
v0 = SmoothieArrayBuilder.buildEither(first: v0_block) */
}
else {
/* let v0_0 = SmoothieArrayBuilder.buildExpression( */ logger.log("Only got free smoothies!") /* ) */
/* let v0_block = SmoothieArrayBuilder.buildBlock(v0_0)
v0 = SmoothieArrayBuilder.buildEither(second: v0_block) */
}

/* return SmoothieArrayBuilder.buildBlock(v0) */
}
```

### buildExpression overloading
```swift
static func buildExpression(_ expression: Smoothie) -> [Smoothie] {
return [expression]
}

static func buildExpression(_ expression: Void) -> [Smoothie] {
return []
}
```

### Modifier-style methos on Ingredient and MeasuredIngredient
```swift
extension Ingredient {
func measured(with unit: UnitVolume) -> MeasuredIngredient {
MeasuredIngredient(self, measurement: Measurement(value: 1, unit: unit))
}
}

extension MeasuredIngredient {
func scaled(by scale: Double) -> MeasuredIngredient {
return MeasuredIngredient(ingredient, measurement: measurement * scale)
}
}
```

## What does a result builder affect?
Applies to one function
- Not nessted functions or closures

Apply by 
- Writing attribute explicitly
- Inferring from protocol requirement
- Inferring from closure prarameter

**Disabled by an explicit return**

### buildBlock overloading
```swift
extension Smoothie {
init(id: Smoothie.ID, title: String, @SmoothieBuilder _ makeIngredients: () -> (String, [MeasuredIngredient])) {
let (description, ingredients) = makeIngredients()
self.init(id: id, title: title, description: description, measuredIngredients: ingredients)
}
}

@resultBuilder
enum SmoothieBuilder {
static func buildBlock(_ description: String, components: MeasuredIngredient...) -> (String, [MeasuredIngredient]) {
return (description, components)
}
}
```

```swift
// Accepting different types

Smoothie(…) /* @SmoothieBuilder */ {
/* let v0 = */ "Filling and refreshing, this smoothie will fill you with joy!"
/* let v1 = */ Ingredient.orange.measured(with: .cups).scaled(by: 1.5)
/* let v2 = */ Ingredient.blueberry.measured(with: .cups)
/* let v3 = */ Ingredient.avocado.measured(with: .cups).scaled(by: 0.2)

/* return SmoothieBuilder.buildBlock(v0, v1, v2, v3) */
}
```

## Additional result builder features
`for` - `in` loops with `buildArray(_:)`
Processing return value with `buildFinalResult(_:)`

### Handling invalid code
#### How Swift improves diagnostics
Documented grammer vs. undocummented grammar

something similar in result builder
```swift
@resultBuilder
enum SmoothieBuilder {
static func buildBlock(_ description: String, components: MeasuredIngredient...) -> (String, [MeasuredIngredient]) {
return (description, components)
}

@available(*, unavailable, message: "first statement of SmoothieBuilder must be its description String")
static func buildBlock(_ components: MeasuredIngredient...) -> (String, [MeasuredIngredient]) {
fatalError()
}
}
```

### Consulation

- DSLs can make complex Swift code much cleaner
- Result builders capture statement results for a DSL to use
- Modifier-style methods work well with result builders
- Clients will have to learn your language, so use DSLs judiciously.
