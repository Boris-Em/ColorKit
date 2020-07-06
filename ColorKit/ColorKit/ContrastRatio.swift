//
//  ContrastRatio.swift
//  ColorKit
//
//  Created by Boris Emorine on 3/13/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// An enumeration which groups contrast ratios based on their readability.
    /// This follows the  Web Content Accessibility Guidelines (WCAG) 2.0.
    public enum ContrastRatioResult {
        /// The contrast ratio between is enough for most people to distinguish the two colors.
        /// It can be used as text / background.
        case acceptable(CGFloat)
        
        /// The contrast ratio is not big enough for most people to distinguish the two colors.
        /// It should only be used for large text / background.
        case acceptableForLargeText(CGFloat)
        
        /// The contrast ratio between the two colors is low.
        /// It will be difficult for most to distinguish the two colors easily.
        /// Do not use these two colors as text / background.
        case low(CGFloat)
        
        init(value: CGFloat) {
            if value >= 4.5 {
                self = .acceptable(value)
            } else if value >= 3.0 {
                self = .acceptableForLargeText(value)
            } else {
                self = .low(value)
            }
        }
        
        var associatedValue: CGFloat {
            switch self {
            case .acceptable(let value),
                 .acceptableForLargeText(let value),
                 .low(let value):
                return value
            }
        }
    }
    
    /// Computes the contrast ratio between the current color instance, and the one passed in.
    /// Contrast ratios can range from 1 to 21 (commonly written 1:1 to 21:1).
    public func contrastRatio(with color: UIColor) -> ContrastRatioResult {
        let l1 = max(color.relativeLuminance, relativeLuminance)
        let l2 = min(color.relativeLuminance, relativeLuminance)

        let contrastRatio = (l1 + 0.05) / (l2 + 0.05)
        return ContrastRatioResult(value: contrastRatio.rounded(.toNearestOrEven, precision: 100))
    }
    
}
