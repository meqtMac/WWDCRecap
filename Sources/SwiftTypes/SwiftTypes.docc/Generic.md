# Swift's Generic System

@Metadata{
    @CallToAction(
    purpose: link,
    url: "https://developer.apple.com/wwdc22/110352")
    @PageImage(
              purpose: card,
               source: "GenericCover",
               alt: "Documentation Preview")
}


## Polymorphism
- Overloads achieve **ad-hoc polymorphism**
- Subtypes achieve **subtype polymorphism**
- Generic achieve **parametric polymorphism**


@TabNavigator {
    @Tab("Class") {
        ```swift
        /// 🧐 somewhat possible but not swifty
        class Animal {
            func eat(_ food: Any) { fatalError("Subclass must implement 'eat'") }
        }
        class Cow: Animal {
            override func eat(_ food: Any) {
                guard let food = food as? Hay else {
                    fatalError()
                }
            }
        }
        
        class Horse: Animal {
            override func eat(_ food: Any) {
                guard let food = food as? Carrot else{
                    fatalError()
                }
            }
        }
        
        class Chicken: Animal {
            override func eat(_ fodd: Any) {
                guard let food = food as? Grain else {
                    fatalError()
                }
            }
        }
        ```
   }
        
   @Tab("Protocol")  {
        ```swift
        protocol Animal {
            associatedtype Feed: AnimalFeed
            associatedtype Habitat
            func eat(_ food: Feed)
        }
       
       struct Cow: Animal {
            func eat(_ food: Hay) { ... }
       }
       
       struct Horse: Animal {
            func eat(_ food: Carrot) { ... }
       }
       
       struct Chicken: Animal {
            func eat(_ food: Grain) { ... }
       }
       ```
   }
        
   @Tab("Generic") {
       ```swift
       struct Farm {
           func feed<A>(_ animal: A) where A: Animal {} // same as next
           func fedd(_ animal: some Animal) {}
       }
       ```
   }
   
   @Tab("Opaque Types") {
       It brings fexibility like Object Oriented Programming's Class for Protocol Oriented Programming with Value Types. But as it's dynamic feature, it add somewhat a layer of indirection and makes code somewhat slower.
       ```swift
       // opaque type
       var body: some View { ... }
       
       // some vs. any
       [some Animal] only one type that conform to Animal
       [any Animal] mutliple types that conform to Animal
       
       // Existential types provides type erasure, swift 5.7
       // Opening type-erased boxes
       ```
   }
}






