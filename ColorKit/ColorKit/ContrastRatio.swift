//
//  ContrastRatio.swift
//  ColorKit
//
//  Created by Boris Emorine on 3/13/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

extension UIColor {
    
    public enum ContrastRatioResult {
        case acceptable(CGFloat)
        case acceptableForLargeText(CGFloat)
        case low(CGFloat)
        
        init(value: CGFloat) {
            if value >= 4.5 {
                self = .acceptable(value)
            } else if value >= 3.0 {
                self = .acceptable(value)
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
    
    /// Contrast ratios can range from 1 to 21 (commonly written 1:1 to 21:1).
    public func contrastRatio(with color: UIColor) -> ContrastRatioResult {
        let l1 = max(color.relativeLuminance, self.relativeLuminance)
        let l2 = min(color.relativeLuminance, self.relativeLuminance)

        let contrastRatio = (l1 + 0.05) / (l2 + 0.05)
        return ContrastRatioResult(value: contrastRatio.rounded(.toNearestOrEven, precision: 100))
    }
    
}
