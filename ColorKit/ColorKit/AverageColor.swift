//
//  AverageColor.swift
//  ColorKit
//
//  Created by Boris Emorine on 5/15/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit
import CoreImage


extension UIImage {
    
    enum ImageColorError: Error {
        /// The `CIImage` instance could not be created.
        case ciImageFailure
        
        /// The `CGImage` instance could not be created.
        case cgImageFailure
        
        /// Failed to get the pixel data from the `CGImage` instance.
        case cgImageDataFailure
        
        /// An error happened during the creation of the image after applying the filter.
        case outputImageFailure
        
        var localizedDescription: String {
            switch self {
            case .ciImageFailure:
                return "Failed to get a `CIImage` instance."
            case .cgImageFailure:
                return "Failed to get a `CGImage` instance."
            case .cgImageDataFailure:
                return "Failed to get image data."
            case .outputImageFailure:
                return "Could not get the output image from the filter."
            }
        }
    }
    
    /// Computes the average color of the image.
    public func averageColor() throws -> UIColor {
        guard let ciImage = CIImage(image: self) else {
            throw ImageColorError.ciImageFailure
        }
        
        guard let areaAverageFilter = CIFilter(name: "CIAreaAverage") else {
            fatalError("Could not create `CIAreaAverage` filter.")
        }
        
        areaAverageFilter.setValue(ciImage, forKey: kCIInputImageKey)
        areaAverageFilter.setValue(CIVector(cgRect: ciImage.extent), forKey: "inputExtent")
        
        guard let outputImage = areaAverageFilter.outputImage else {
            throw ImageColorError.outputImageFailure
        }

        let context = CIContext()
        var bitmap = [UInt8](repeating: 0, count: 4)
        
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())

        let averageColor = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
        
        return averageColor
    }
    
}
