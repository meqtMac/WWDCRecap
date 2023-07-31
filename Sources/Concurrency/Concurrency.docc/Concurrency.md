# Swift Concurrency

Recap of Swift Concurrency in years of WWDC Swift Session

## Meet Swift AsyncAlgorithms
 [WWDC22: Meet Swift Async Algorithms](https://developer.apple.com/wwdc22/110355)

### Collection Initializers from a Async Sequence

## Eliminate data races using Swift Concurrency
[WWDC22: Eliminate data races using Swift Concurrency](https://developer.apple.com/wwdc22/110351)

A model for data-race free model of concurrency.

### Task isolation
```swift
Task.detached{
    let fish = await catchFish()
    let dinner = await cook(fish)
    await eat(dinner)
}
```

#### Communication between boats
We like value types in swift.

#### Sendable types are safe to share
```swift
struct Task<Success: Sendable, Failure: Error> {
    value: Success {
        get async throws { ... }
    }
}
```


#### Checking Sendable across task boundaries

#### Sharing across boats, safely

Sendable conformance are checked at compile time. Sendable type can be propagate.


```swift
func nextRound(islands: [Island]) async {
    for await island in islands {
        await island.advanceTime()
    }
}
```

Non-Sendable data cannot be shared between a task and an actor.

### Actor reference isolation
All Actor types are sendable.

```swift
actor Island {
    var flock: [Chicken]
    var food: [Pineapple]
    func advanceTime() {
        let totalSlices = food.indices.reduce(0) { (total, nextIndex) in 
            total + food[nextIndex].slice()
        }

        Task {
            flock.map(Chicken.produce)
        }

        Task.detached {
            let ripePineapples = await food.filer { $0.ripeness == .perfect }
            print("There are \(ripePineapples.count) ripe pineapples on the island.")
        }
    }
}
```

#### Non-isolated code
Functions within actor can be explicitly marked non-isolated.

```swift
extension Island {
    nonisolated func meetTheFlock() async {
        let flockNames = await flock.map { $0.name }
        print("Meet our fabulous flock: \(flockNames)")
    }
}
```
Non-isolated async code executes on the cooperative pool.

### `@MainActor` is an actor
Main actor carries a lot of state related to the program's UI.

```swift
@MainActor func updateView() { ... } // function
Task { @MainActor in  // closure
    view.selectedChicken = lily
}
@MainActor // value access and function call
class ChickenValley {
    var flock: [Chicken]
    var food: [Pineapple]

    func advanceTime() { ... }
}
```

#### Architecting your app with actors.

### Atomoicity
Actors run one task at a time.

When you stop running on an actor, it can run other tasks.
```swift
// Non-transactional code
func deposit(pineapples: [Pineapple], onto island: Island) async {
    var food = await island.food
    food += pineapples
    await island.food = food
} // there got two await in the function, and there's nothing make sure what happens inside.

// Another example.
actor Counter {
    var value = 0
    func increment(by n: Int = 1) -> Int {
        for _ in 0..<n { value += 1 }
        return value
    }
}
let counter = Counter()
let task1 = Task { print(await counter.increment(by: 10000), await counter.value, "by Task1") }
let task2 = Task { print(await counter.increment(by: 10000), await counter.value, "by Task2") }
// wait for two tasks to end.
await withTaskGroup(of: Void.self) { group in
    group.addTask { await task1.value }
    group.addTask { await task2.value }
    await group.waitForAll()
}
/*: Output 😱
10000 20000 by Task1
20000 20000 by Task2
*/
```
the right way that makes app work in a way you want.
```swift
// Synchronous functions are never interrupted.s
extension Island {
    func deposit(pineapples: [Pineapples]) {
        var food = self.food
        food += pineapples
        self.food = food
    }
}
```

#### Think transactionally
- Identify synchronous operations that can be interleaved.
- Keep async actor operations simple

### Ordering

#### Actors are not strictly first-in first out.
Actors execute the highest-priority work first.

Important semantic difference vs. serial Dispatch queues.

#### Tools for ordering
- Tasks run code in order
- AsyncStreams deliver elements in order
for await event in eventStream {
    await process(event)
}

### Eliminating data races.
- Sendable
- Staged rollout of Sendable checking throughout Swift for completion in Swift 6.
- Minimal Strict Concurrency Check: Only check explict
- Targeted Strict Concurrency Checking.
```swift
@preconcurrency
```
- Complete checking approximates Swift 6 data-race elimination
```swift
import FarmAnimals

func doWork(_ body: @Sendable @escaping () -> Void) {
  DispatchQueue.global().async {
    body()
  }
}

func visit(friend: Chicken) {
  doWork {
    friend.play()
  }
}
```

#### The road to data-race safety
Swift Comiler - Language
- Strict Concurrency Checking
    - Minimal
    - Targeted
    - Complete


## Meet Swift AsyncAlgorithms
 [WWDC23: Beyond the basics of structured concurrency](https://developer.apple.com/wwdc23/10170)

### Structured Concurrency
```swift
async let future = ...
taskGroup.add {
    
}
```
