
//
//  CGFloatExtensions.swift
//  ColorKit
//
//  Created by Boris Emorine on 2/26/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    
    func rounded(_ rule: FloatingPointRoundingRule, precision: Int) -> CGFloat {
        return (self * CGFloat(precision)).rounded(rule) / CGFloat(precision)
    }
    
}
