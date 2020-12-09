//
//  Name.swift
//  ColorKit
//
//  Created by Boris Emorine on 12/9/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// This function gives a readable name (in English) to the current `UIColor` instance.
    /// - Returns: The name of the color.
    public func name() -> String {
        let colorList = NamedColorList.BasicColors
        var closestColor: (UIColor, String)?
        var bestMatch: UIColor.ColorDifferenceResult = .init(value: CGFloat.infinity)
        
        for color in colorList {
            let difference = self.difference(from: color.0, using: .CIE94)
            
            if difference < bestMatch {
                closestColor = color
                bestMatch = difference
            }
        }
        
        return closestColor!.1
    }
    
}

/// Adds the content of two dictionaries together.
private func +=<UIColor, String> (lhs: [UIColor: String], rhs: [UIColor: String]) -> [UIColor: String] {
    let summedUpDictionay = lhs.reduce(into: rhs) { (result, colorNamePair) in
        result[colorNamePair.key] = colorNamePair.value
    }
    return summedUpDictionay
}

/// A collection of lists of colors and their names.
struct NamedColorList {
    
    static let BasicColors = AdditivePrimaryColors += AdditiveSecondaryColors += AdditiveTertiaryColors += GrayShadeColors
    
    static let AdditivePrimaryColors = [
        UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0): "red",
        UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0): "green",
        UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0): "blue"
    ]
    
    static let AdditiveSecondaryColors = [
        UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0): "yellow",
        UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0): "magenta",
        UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0): "cyan"
    ]
    
    static let AdditiveTertiaryColors = [
        UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0): "azure",
        UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0): "violet",
        UIColor(red: 1.0, green: 0.0, blue: 0.5, alpha: 1.0): "rose",
        UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0): "orange",
        UIColor(red: 0.5, green: 1.0, blue: 0.0, alpha: 1.0): "chartreuse",
        UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0): "spring green"
    ]
    
    static let GrayShadeColors = [
        UIColor.black: "black",
        UIColor.white: "white",
        UIColor.gray: "gray"
    ]
    
}
