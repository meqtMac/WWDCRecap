//
//  SwiftGeneric.swift
//
//
//  Created by 蒋艺 on 2023/6/28.
//

struct SwiftGeneric {
    
}

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
