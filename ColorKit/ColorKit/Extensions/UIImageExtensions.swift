//
//  UIImageExtensions.swift
//  ColorKit
//
//  Created by Boris Emorine on 5/30/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

extension UIImage {
    
    var resolution: CGSize {
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    func resize(to targetSize: CGSize) -> UIImage {
        guard targetSize != resolution else {
            return self
        }
                
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = true
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        let resizedImage = renderer.image { _ in
            self.draw(in: CGRect(origin: CGPoint.zero, size: targetSize))
        }
        
        return resizedImage
    }
    
}
