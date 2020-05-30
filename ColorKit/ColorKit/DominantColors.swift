//
//  DominantColors.swift
//  ColorKit
//
//  Created by Boris Emorine on 5/19/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit


extension UIImage {
    
    /// How precise should the dominant color algorithm be.
    /// The lower the quality, the faster the algorithm.
    /// `.best` should only be reserved for very small images.
    public enum DominantColorQuality {
        case low
        case fair
        case high
        case best
        
        var prefferedImageArea: CGFloat? {
            switch self {
            case .low:
                return 100
            case .fair:
                return 10_000
            case .high:
                return 100_000
            case .best:
                return nil
            }
        }
        
        /// Returns a new size (with the same aspect ratio) that takes into account the quality to match.
        /// For example with a `.low` quality, the returned size will be much smaller.
        /// On the opposite, with a `.best` quality, the returned size will be identical to the original size.
        func targetSize(for originalSize: CGSize) -> CGSize {
            guard let prefferedImageArea = prefferedImageArea else {
                return originalSize
            }
            
            let originalArea = originalSize.area
            
            guard originalArea > prefferedImageArea else {
                return originalSize
            }
            
            return originalSize.transformToFit(in: prefferedImageArea)
        }
    }
    
    /// A simple structure containing a color, and a count.
    public struct ColorFrequency {
        let color: UIColor
        let count: Int
    }
    
    /// Returns the dominant colors of the image, via an ordered array where the first element is the most common color on the image.
    public func dominantColors(with quality: DominantColorQuality = .fair) throws -> [ColorFrequency] {
        let targetSize = quality.targetSize(for: resolution)
        
        let resizedImage = resize(to: targetSize)
        guard let cgImage = resizedImage.cgImage else {
            throw ImageColorError.CGImageFailure
        }
        
        let cfData = cgImage.dataProvider!.data
        guard let data = CFDataGetBytePtr(cfData) else {
            throw ImageColorError.CGImageDataFailure
        }
        
        let colorsCountedSet = NSCountedSet(capacity: Int(targetSize.area))
        
        struct RGB: Hashable {
            let R: UInt8
            let G: UInt8
            let B: UInt8
        }

        for yCoordonate in 0 ..< cgImage.height {
            for xCoordonate in 0 ..< cgImage.width {
                let index = (cgImage.width * yCoordonate + xCoordonate) * 4
                
                // Let's make sure there is enough alpha.
                guard data[index + 3] > 200 else { continue }
                
                let pixelColor = RGB(R: data[index + 0], G: data[index + 1], B:  data[index + 2])
                colorsCountedSet.add(pixelColor)
            }
        }

        // Let's only keep colors that are at least present in 0.01% of the area
        let minCountThreshold = Int(targetSize.area * (0.01 / 100.0))
        
        let filteredColorsCountMap = colorsCountedSet.compactMap { (rgb) -> ColorFrequency? in
            let count = colorsCountedSet.count(for: rgb)
            
            guard count > minCountThreshold else {
                return nil
            }
            
            let rgb = rgb as! RGB

            return ColorFrequency(color: UIColor(red: CGFloat(rgb.R) / 255.0, green: CGFloat(rgb.G) / 255.0, blue: CGFloat(rgb.B) / 255.0, alpha: 1.0), count: count)
        }
        
        let sortedColorsCountMap = filteredColorsCountMap.sorted { (lhs, rhs) -> Bool in
            return lhs.count > rhs.count
        }
        
        return sortedColorsCountMap
    }
    
}
