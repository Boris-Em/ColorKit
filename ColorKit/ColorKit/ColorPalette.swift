//
//  ColorPalette.swift
//  ColorKit
//
//  Created by Boris Emorine on 7/6/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

/// A simple structure used to represent color palettes.
public struct ColorPalette {
    
    /// The color that should be used as a background.
    public let background: UIColor
    
    /// The color that should be used as the primary detail. For example the main text.
    public let primary: UIColor
    
    /// The color that should be used as the secondary detail. For example text that isn't as important as the one represented by the primary property.
    public let secondary: UIColor?
    
    /// Initializes a coherant color palette based on the passed in colors.
    /// This makes it easy to generate palettes from a collection of colors.
    ///
    /// - Parameters:
    ///   - colors: The colors that will be used to generate the color palette. The best colors will be selected to have a color palette with enough contrast. At least two colors should be passed in.
    ///   - darkBackground: Whether the color palette should have a dark or bright background.
    ///   - ignoreContrastRatio: Whether the color paletter should ignore the contrast ratio between the different colors. It is recommended to set this value to `false` (default) if the color paletter will be used to display text.
    public init?(colors: [UIColor], darkBackground: Bool = true, ignoreContrastRatio: Bool = false) {
        guard colors.count > 1 else {
            return nil
        }
        
        var darkestColor: UIColor?
        var brightestColor: UIColor?
        
        colors.forEach { (color) in
            if color.relativeLuminance < darkestColor?.relativeLuminance ?? CGFloat.greatestFiniteMagnitude {
                darkestColor = color
            }
            
            if color.relativeLuminance > brightestColor?.relativeLuminance ?? CGFloat.leastNormalMagnitude {
                brightestColor = color
            }
        }
        
        var backgroundColor: UIColor!
        var primaryColor: UIColor!
        
        if !ignoreContrastRatio {
            let backgroundPrimaryContrastRatio = darkestColor!.contrastRatio(with: brightestColor!)
            switch backgroundPrimaryContrastRatio {
            case .acceptable, .acceptableForLargeText:
                break
            default:
                return nil
            }
        }
        
        if darkBackground {
            backgroundColor = darkestColor!
            primaryColor = brightestColor!
        } else {
            backgroundColor = brightestColor!
            primaryColor = darkestColor!
        }
        
        let secondaryColor = colors.first { (color) -> Bool in
            if !ignoreContrastRatio {
                let backgroundColorConstratRatio = color.contrastRatio(with: backgroundColor)
                switch backgroundColorConstratRatio {
                case .acceptable , .acceptableForLargeText:
                    break
                default: return false
                }
            }
            
            let backgroundColorDifference = color.difference(from: backgroundColor)
            switch backgroundColorDifference {
            case .different, .far:
                let primaryColorDifference = color.difference(from: primaryColor)
                switch primaryColorDifference {
                case .near, .different, .far:
                    return true
                default:
                    return false
                }
            default:
                return false
            }
        }
        
        self.background = backgroundColor
        self.primary = primaryColor
        self.secondary = secondaryColor
    }
    
}
