# Swift and Objective-C Interoperablity

WWDC15: Swift and Objective-C Interoperability



## Overview

Discover new features that make it easier than ever to craft Objective-C APIs that work beautifully in Swift, as well as new Swift language features that provide even better interoperability. Apple engineers will also discuss enhancements to Apple's SDKs that improve the Swift experience.

## Roadmap 
- Working with Objective-C
- Error Handling
- Nullabiliyt Annotations
- Lightweight Generics
- "Kindof" Types


## Working with Objective-C
Subclasses of NSObject
- Not *private*
- Not using Swift features
- Not for @objc protocols

Being explicit
- @IBOutlet
-  @IBAction
- @NSManaged
- dynamic
- @objc

[Using Swift with Cocoa and Objective-C](http://developer.apple.com/swift)

### Selector Conflicts
- @nonobjc

### Function Pointer
- Used in C for callbacks
- Like closures, but can't carry state. for example([weak self])
```swift
// Swift 2.0
typedef void (*dispatch_function_t)(void *);

typealias dispatch_function_t = 
@convention(c) (UnsafeMutablePointer<Void>) -> Void
```

## Error Handling
```objc
- (id)contentsForTypes:(NSString *)typeName
                 error:(NSError **)outError;
```

```swift
func contentsForTypes(typeName: String) throws -> AnyObject
```

### Return types
```swift
func readFromURL(url: NSURL) throws -> Void 
```
```objc
- (BOOL)readFromURL:(NSURL *)url
              error:(NSError **)outlet;
```

### Callbacks

## Objective-C Side

### Nullability for Objective-C
- nonatomic
- readonly
- copy

- nullabla -> UIView?
- nonnull -> UIView
- `null_unspecified` -> UIView!

```objc
NS_ASSUME_NONNULL_BEGIN
@interface UIView
@property(nonatomic, readonly, nullable) UIView *superview;
@property(nonatomic, copy) NSArray *subviews;
- (nullable UIView *) hitTest: (CGPoint) point withEvent: (nullable UIEvent *)event;
@end
NS_ASSUME_NONNULL_END
```

### C Pointers
```c
CFArrayRef __nonnull CFArrayCreate(
    CFAllocatorFef __nullable allocator,
    const void * __nonnull * __nullable values,
    CFIndex numValues,
    const CFArrayCallBacks * __nullable callBacks);
```

### LightGenerics for Objective-C
```objc
@interface UIView
@property(nonatomic, readonly, copy) NSArray *subviews;
@end
```
```swift
class UIView {
    var subviews: [AnyObject] { get }
}
```

with Generics

```objc
@interface UIView
@property(nonatomic, readonly, copy) NSArray<UIView *> *subviews;
@end
```


#### Type Safety for Typed Collections

🤔It's quite like type hinting added in python.

#### Parameterized Classes

#### Backward Compatibility

### `Kindof` Types for Objective-C

#### A Problem of Evolution
from 
```objc
- (id) 
```

to 
```swift
- (nullable __kindof NSView *)
```

#### Should I Use id in an API?

