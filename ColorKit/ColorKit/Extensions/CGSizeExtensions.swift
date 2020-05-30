//
//  CGSizeExtensions.swift
//  ColorKit
//
//  Created by Boris Emorine on 5/30/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import CoreGraphics

extension CGSize {
    
    /// The area of the size.
    var area: CGFloat {
        return width * height
    }
    
    /// Returns a new size of the target area, keeping the same aspect ratio.
    func transformToFit(in targetArea: CGFloat) -> CGSize {
        let ratio = area / targetArea
        let targetSize = CGSize(width: width / sqrt(ratio), height: height / sqrt(ratio))
        
        return targetSize
    }
    
}
