//
//  Name.swift
//  ColorKit
//
//  Created by Boris Emorine on 12/9/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// This function gives a readable name to the current `UIColor` instance.
    /// Warning: some languages may not be supported.
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
        UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.primary.red", bundle: Bundle(for: ColorFrequency.self), comment: "red"),
        UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.primary.green", bundle: Bundle(for: ColorFrequency.self), comment: "green"),
        UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.primary.blue", bundle: Bundle(for: ColorFrequency.self), comment: "blue")
    ]
    
    static let AdditiveSecondaryColors = [
        UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.secondary.yellow", bundle: Bundle(for: ColorFrequency.self), comment: "yellow"),
        UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.secondary.magenta", bundle: Bundle(for: ColorFrequency.self), comment: "magenta"),
        UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.secondary.cyan", bundle: Bundle(for: ColorFrequency.self), comment: "cyan")
    ]
    
    static let AdditiveTertiaryColors = [
        UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.tertiary.azure", bundle: Bundle(for: ColorFrequency.self), comment: "azure"),
        UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.tertiary.violet", bundle: Bundle(for: ColorFrequency.self), comment: "violet"),
        UIColor(red: 1.0, green: 0.0, blue: 0.5, alpha: 1.0): NSLocalizedString("colorkit.color.name.tertiary.rose", bundle: Bundle(for: ColorFrequency.self), comment: "rose"),
        UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.tertiary.orange", bundle: Bundle(for: ColorFrequency.self), comment: "orange"),
        UIColor(red: 0.5, green: 1.0, blue: 0.0, alpha: 1.0): NSLocalizedString("colorkit.color.name.tertiary.chartreuse", bundle: Bundle(for: ColorFrequency.self), comment: "chartreuse"),
        UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0): NSLocalizedString("colorkit.color.name.tertiary.sprint_green", bundle: Bundle(for: ColorFrequency.self), comment: "spring green")
    ]
    
    static let GrayShadeColors = [
        UIColor.black: NSLocalizedString("colorkit.color.name.gray_shade.black", bundle: Bundle(for: ColorFrequency.self), comment: "black"),
        UIColor.white: NSLocalizedString("colorkit.color.name.gray_shade.white", bundle: Bundle(for: ColorFrequency.self), comment: "white"),
        UIColor.gray: NSLocalizedString("colorkit.color.name.gray_shade.gray", bundle: Bundle(for: ColorFrequency.self), comment: "gray")
    ]
    
}
