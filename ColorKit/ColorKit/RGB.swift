//
//  RGB.swift
//  ColorKit
//
//  Created by Boris Emorine on 2/24/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

struct RGB {
    let R: CGFloat
    let G: CGFloat
    let B: CGFloat
}

extension UIColor {
    
    // MARK: - Pulic
    
    /// The red (R) channel of the RGB color space as a value from 0.0 to 1.0.
    public var red: CGFloat {
        CIColor(color: self).red
    }
    
    /// The green (G) channel of the RGB color space as a value from 0.0 to 1.0.
    public var green: CGFloat {
        CIColor(color: self).green
    }
    
    /// The blue (B) channel of the RGB color space as a value from 0.0 to 1.0.
    public var blue: CGFloat {
        CIColor(color: self).blue
    }
    
    /// The alpha (a) channel of the RGBa color space as a value from 0.0 to 1.0.
    public var alpha: CGFloat {
        CIColor(color: self).alpha
    }
    
    // MARK: Internal
    
    var red255: CGFloat {
        self.red * 255.0
    }
    
    var green255: CGFloat {
        self.green * 255.0
    }
    
    var blue255: CGFloat {
        self.blue * 255.0
    }
    
    var rgb: RGB {
        return RGB(R: self.red, G: self.green, B: self.blue)
    }
        
}
