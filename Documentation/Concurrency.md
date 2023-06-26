# Visualize and optimize Swift concurrency

![Visual and optimize Swift concurrency](https://developer.apple.com/wwdc22/110350)
![Meet async/await in Swift](https://developer.apple.com/wwdc21/10132)
![Explore structured concurrency in Swift](https://developer.apple.com/wwdc21/10134)
![Protect mutable state with Swift actors](https://developer.apple.com/wwdc21/10133)
![Swift concurrency: Behind the scenes](https://developer.apple.com/wwdc21/10254)
![Use async/await with URLSession](https://developer.apple.com/wwdc21/10095)
## Swift Concurrency Recap
### Async/await
### Tasks
### Structured concurrency
### Actors

## Concurrency Optimization
### Main actor blocking
### actor contention
serialized tasks. -> 🐢

Thread Pool -> concurrently
in actor ``noisolated``
for task ``detached``
```swift
noisolated async
and use await for actor access inside

// detached task don't inheriate on the context
Task.detached {
    detached task must explictly capture self.
}
```

### Thread pool exhaustion
Avoid blocking calls
Avoid conditon variables and semaphores
Use async API for blocking operations
- Especially file/network IO
Make blocking calls outside Swift Concurrency

### Continuation misuse
External callback-based API
should be called only once.
withCheckedContinuation

# Eliminate data races using Swift Concurrency

[Eliminate data races using Swift Concurrency](https://developer.apple.com/wwdc22/110351)

## Task isolation
- Sequential
- Asynchronous
- Self-contained

### Communication between boats

#### `struct` 
value types

#### `class`
reference types

#### `Sendable`
```swift
protocol Sendable {
}
✅ struct Pineapple: Sendable { }
❌ class Chicken: Sendable { }

struct Task<Success: Sendable, Failure: Error> {
    var value: Success {
        get async throws { }
    }
}
```

Sendable protocol propagate.

class can conform to `Sendable` under limited conditions.
`@unchecked Sendable`


