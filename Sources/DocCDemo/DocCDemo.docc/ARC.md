# ARC in swift

## Implementation

### Value type
- `struct`
deallocated when it goes out of the scope.

### Reference type.
- `class`
- `actor`

Swift compiler insert retain and release.

### Deallocate  time

### Observable object lifetimes.

#### Reference Cycle -> Memory Leak?
Break reference cycles.
- `weak` -> nil
- `unown` -> traps

`weak` and `unown` aren't enloved in reference count.
 ```swift
 
 class Traveler {
    var name: String
    var account: Account?
}

class Account {
    weak var traveler: Traveler?
    var points: Int
    func printSummary() {
        print("\(traveler!.name) has \(points) points")
    }
}

func test() {
    let traveler = Traveler(name: "Lily")
    let account = Account(traveler: traveler, points: 1000)
    traveler.account = account
    account.printSummary() // traveler's reference can be 0, so this can crash.
}
 ```
 
 - `withExtendedLifetime`
 ```swift
 func test() {
    let traveler = Traveler(name: "Lily")
    let account = Account(traveler: traveler, points: 1000)
    traveler.account = account
    withExtendedLifetime(traveler) {
        account.printSummary()
    }
}

func test() {
    let traveler = Traveler(name: "Lily")
    let account = Account(traveler: traveler, points: 1000)
    traveler.account = account
    account.printSummary()
    withExtendedLifetime(traveler) {}
}

func test() {
    let traveler = Traveler(name: "Lily")
    let account = Account(traveler: traveler, points: 1000)
    defer {withExtendedLifetime(traveler) {}}
    traveler.account = account
    account.printSummary()
}
 ```

A better solution: eliminate potenional weak reference access
```swift
 class Traveler {
    var name: String
    var account: Account?
    func printSummary() {
        if let account = account {
            print("\(name) has \(account.points) points")
        }
    }
}

class Account {
    private weak var traveler: Traveler?
    var points: Int
}

func test() {
    let traveler = Traveler(name: "Lily")
    let account = Account(traveler: traveler, points: 1000)
    traveler.account = account
    traveler.printSummary()
}   
```

#### Redesign avoid Reference cycle
```swift
class PersonalInfo {
    var name: String
}

class Traveler {
    var info: PersonalInfo
    var account: Account?
}

class Account {
    var info: PersonalInfo
    var points: Int
}
```

#### Deinitializer side-effects
 

