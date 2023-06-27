//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/6/27.
//

//import Foundation
import SwiftUI

public struct Sloth {
    let power: Int
}
/// An extension that facilitates the display of sloths in user interface
public extension Image {
    /// Create an image from the given sloth.
    ///
    /// Use this initializer to display
    ///
    /// ```swift
    /// let iceSloth = Sloth(name: "Super Sloth", color: .red)
    /// ```
    /// ![Documentation Preview Editor in Xcode 15](DocumentPreview)
    ///  This is what's like 
    init(_ sloth: Sloth) {
        self.init("\(sloth.power)-sloth")
    }
}
