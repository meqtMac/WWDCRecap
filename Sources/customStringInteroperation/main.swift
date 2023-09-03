//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/11.
//

import Foundation

enum ANSIColor: String {
    case black = "\u{001B}[30m"
    case red = "\u{001B}[31m"
    case green = "\u{001B}[32m"
    case yellow = "\u{001B}[33m"
    case blue = "\u{001B}[34m"
    case magenta = "\u{001B}[35m"
    case cyan = "\u{001B}[36m"
    case white = "\u{001B}[37m"
    
    var reset: String {
        return "\u{001B}[0m"
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Int, color: ANSIColor) {
        self.appendInterpolation(color.rawValue + value.formatted(.number) + color.reset)
    }
}
