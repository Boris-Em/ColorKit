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
    
    public var red: CGFloat {
        CIColor(color: self).red
    }
    
    public var green: CGFloat {
        CIColor(color: self).green
    }
    
    public var blue: CGFloat {
        CIColor(color: self).blue
    }
    
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
