//
//  Comparison.swift
//  ColorKit
//
//  Created by Boris Emorine on 2/24/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

extension UIColor {
    
    public enum DeltaEFormula {
        case euclidean
        case CIE76
        case CIE94
        case CIEDE2000
    }
    
    public func difference(from color: UIColor, using formula: DeltaEFormula = .CIE94) -> CGFloat {
        switch formula {
        case .euclidean:
            return sqrt(pow(self.red255 - color.red255, 2) + pow(self.green255 - color.green255, 2) + pow(self.blue255 - color.blue255, 2))
        default:
            return -1
        }
    }
    
}
