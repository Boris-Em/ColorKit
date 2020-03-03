//
//  Comparison.swift
//  ColorKit
//
//  Created by Boris Emorine on 2/24/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

extension UIColor {
    
    public enum ColorComparaisonResult {
        /// There is no difference between the two colors.
        case indentical(CGFloat)
        
        /// The difference between the two colors is not perceptible by human eyes.
        case similar(CGFloat)
        
        /// The difference between the two colors is perceptible through close observation.
        case close(CGFloat)
        
        /// The difference between the two colors is perceptible at a glance.
        case near(CGFloat)
        
        /// The two colors are different, but not opposite.
        case different(CGFloat)
        
        /// The two colors are more opposite than similar.
        case far(CGFloat)
        
        /// The two colors are exact opposite.
        case opposite(CGFloat)
        
        var associatedValue: CGFloat {
            switch self {
            case .indentical(let value):
                return value
            case .similar(let value):
                return value
            case .close(let value):
                return value
            case .near(let value):
                return value
            case .different(let value):
                return value
            case .far(let value):
                return value
            case .opposite(let value):
                return value
            }
        }
                
        init(value: CGFloat) {
            if value == 0 {
                self = .indentical(value)
            } else if value <= 1.0 {
                self = .similar(value)
            } else if value <= 2.0 {
                self = .close(value)
            } else if value <= 10.0 {
                self = .near(value)
            } else if value <= 50.0 {
                self = .different(value)
            } else if value < 100.0 {
                self = .far(value)
            } else {
                self = .opposite(value)
            }
        }
    }
    
    public enum DeltaEFormula {
        case euclidean
        case CIE76
        case CIE94
        case CIEDE2000
    }
    
    public func difference(from color: UIColor, using formula: DeltaEFormula = .CIE94) -> ColorComparaisonResult {
        switch formula {
        case .euclidean:
            let differenceValue = sqrt(pow(self.red255 - color.red255, 2) + pow(self.green255 - color.green255, 2) + pow(self.blue255 - color.blue255, 2))
            let roundedDifferenceValue = differenceValue.rounded(.toNearestOrEven, precision: 100)
            return ColorComparaisonResult(value: roundedDifferenceValue)
        case .CIE76:
            let differenceValue = sqrt(pow(color.L - self.L, 2) + pow(color.a - self.a, 2) + pow(color.b - self.b, 2))
            let roundedDifferenceValue = differenceValue.rounded(.toNearestOrEven, precision: 100)
            return ColorComparaisonResult(value: roundedDifferenceValue)
        default:
            return ColorComparaisonResult(value: -1)
        }
    }
    
}
