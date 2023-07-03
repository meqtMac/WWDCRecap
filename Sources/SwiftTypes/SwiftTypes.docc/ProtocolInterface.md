# Design protocol interfaces in Swift

@Metadata {
    @CallToAction(
     purpose: link,
     url: "https://developer.apple.com/wwdc22/110353"
     )
    @PageImage(
              purpose: card,
               source: "ProtocolCover",
               alt: "Documentation Preview")
}

WWDC22: Design protocol interfaces in Swift

Let's look at two examples
First one with some problem: 
```swift
// problems 😣, there's no guarntee that AnimalFeed and Crop.FeedType will be the same
protocol AnimalFeed {
    associatedtype CropType: Crop
    static func grow() -> CropType
}

protocol Crop {
    associatedtype FeedType: AnimalFeed
    func harvest() -> FeedType
}
```

how to fix this
```swift
// right ✅
protocol AnimalFeed {
    associatedtype CropType: Crop
    where CropType.FeedType == Self // guarnteed
    static func grow() -> CropType
}

protocol Crop {
    associatedtype FeedType: AnimalFeed
    func harvest() -> FeedType
}

struct Fram {
}

protocol Animal {
    var isHungry: Bool { get }
    
    associatedtype FeedType: AnimalFeed
    func eat(_: FeedType)
}

extension Fram {
    private func feedAnimal(_ animal: some Animal) {
        let crop = type(of: animal).FeedType.grow()
        let feed = crop.harvest()
        animal.eat(feed)
    }
}
```
