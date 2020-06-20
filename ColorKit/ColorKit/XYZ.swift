//
//  XYZ.swift
//  ColorKit
//
//  Created by Boris Emorine on 2/24/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

struct XYZ {
    let X: CGFloat
    let Y: CGFloat
    let Z: CGFloat
}

struct XYZCalculator {
    
    static func convert(rgb: RGB) -> XYZ {
        func transform(value: CGFloat) -> CGFloat {
            if value > 0.04045 {
                return pow((value + 0.055) / 1.055, 2.4)
            }
            
            return value / 12.92
        }
        
        let red = transform(value: rgb.R) * 100.0
        let green = transform(value: rgb.G) * 100.0
        let blue = transform(value: rgb.B) * 100.0
        
        let X = (red * 0.4124 + green * 0.3576 + blue * 0.1805).rounded(.toNearestOrEven, precision: 100)
        let Y = (red * 0.2126 + green * 0.7152 + blue * 0.0722).rounded(.toNearestOrEven, precision: 100)
        let Z = (red * 0.0193 + green * 0.1192 + blue * 0.9505).rounded(.toNearestOrEven, precision: 100)

        return XYZ(X: X, Y: Y, Z: Z)
    }
    
}

extension UIColor {
    
    /// The X value of the XYZ color space.
    public var X: CGFloat {
        let XYZ = XYZCalculator.convert(rgb: self.rgb)
        return XYZ.X
    }
    
    /// The Y value of the XYZ color space.
    public var Y: CGFloat {
        let XYZ = XYZCalculator.convert(rgb: self.rgb)
        return XYZ.Y
    }
    
    /// The Z value of the XYZ color space.
    public var Z: CGFloat {
        let XYZ = XYZCalculator.convert(rgb: self.rgb)
        return XYZ.Z
    }
    
}
