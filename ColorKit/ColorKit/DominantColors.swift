//
//  DominantColors.swift
//  ColorKit
//
//  Created by Boris Emorine on 5/19/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit
import CoreImage

/// A simple structure containing a color, and a frequency.
public class ColorFrequency: CustomStringConvertible {
    
    /// A simple `UIColor` instance.
    public let color: UIColor
    
    /// The frequency of the color.
    /// That is, how much it is present.
    public var frequency: CGFloat
    
    public var description: String {
        return "Color: \(color) - Frequency: \(frequency)"
    }
    
    init(color: UIColor, count: CGFloat) {
        self.frequency = count
        self.color = color
    }
}

extension UIImage {
    
    public enum DominantColorAlgorithm {
        
        /// Finds the dominant colors of an image by iterating, grouping and sorting its pixels.
        case iterative
        
        /// Finds the dominant colors of an image by using using a k-means clustering algorithm.
        case kMeansClustering
    }
    
    /// Reoresents how precise the dominant color algorithm should be.
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
                return 1_000
            case .fair:
                return 10_000
            case .high:
                return 100_000
            case .best:
                return nil
            }
        }
        
        var kMeansInputPasses: Int {
            switch self {
            case .low:
                return 1
            case .fair:
                return 10
            case .high:
                return 15
            case .best:
                return 20
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
    
    /// Attempts to computes the dominant colors of the image.
    /// This is not the absolute dominent colors, but instead colors that are similar are groupped together.
    /// This avoids having to deal with many shades of the same colors, which are frequent when dealing with compression artifacts (jpeg etc.).
    /// - Parameters:
    ///   - quality: The quality used to determine the dominant colors. A higher quality will yield more accurate results, but will be slower.
    ///   - algorithm: The algorithm used to determine the dominant colors. When using a k-means algorithm (`kMeansClustering`), a `CIKMeans` CIFilter isused. Unfortunately this filter doesn't work on the simulator.
    /// - Returns: The dominant colors as array of `UIColor` instances. When using the `.iterative` algorithm, this array is ordered where the first color is the most dominant one.
    public func dominantColors(with quality: DominantColorQuality = .fair, algorithm: DominantColorAlgorithm = .iterative) throws -> [UIColor] {
        switch algorithm {
        case .iterative:
            let dominantColorFrequencies = try self.dominantColorFrequencies(with: quality)
            let dominantColors = dominantColorFrequencies.map { (colorFrequency) -> UIColor in
                return colorFrequency.color
            }
            
            return dominantColors
        case .kMeansClustering:
            let dominantcolors = try kMeansClustering(with: quality)
            return dominantcolors
        }
    }
    
    /// Attempts to computes the dominant colors of the image.
    /// This is not the absolute dominent colors, but instead colors that are similar are groupped together.
    /// This avoid having to deal with many shades of the same colors, which are frequent when dealing with compression artifacts (jpeg etc.).
    /// - Parameters:
    ///   - quality: The quality used to determine the dominant colors. A higher quality will yield more accurate results, but will be slower.
    /// - Returns: The dominant colors as an ordered array of `ColorFrequency` instances, where the first element is the most common one. The frequency is represented as a percentage ranging from 0 to 1.
    public func dominantColorFrequencies(with quality: DominantColorQuality = .fair) throws -> [ColorFrequency] {
        
        // ------
        // Step 1: Resize the image based on the requested quality
        // ------
        
        let targetSize = quality.targetSize(for: resolution)
        
        let resizedImage = resize(to: targetSize)
        guard let cgImage = resizedImage.cgImage else {
            throw ImageColorError.cgImageFailure
        }
        
        let cfData = cgImage.dataProvider!.data
        guard let data = CFDataGetBytePtr(cfData) else {
            throw ImageColorError.cgImageDataFailure
        }
        
        // ------
        // Step 2: Add each pixel to a NSCountedSet. This will give us a count for each color.
        // ------
        
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
                guard data[index + 3] > 150 else { continue }
                
                let pixelColor = RGB(R: data[index + 0], G: data[index + 1], B:  data[index + 2])
                colorsCountedSet.add(pixelColor)
            }
        }
        
        // ------
        // Step 3: Remove colors that are barely present on the image.
        // ------

        let minCountThreshold = Int(targetSize.area * (0.01 / 100.0))
        
        let filteredColorsCountMap = colorsCountedSet.compactMap { (rgb) -> ColorFrequency? in
            let count = colorsCountedSet.count(for: rgb)
            
            guard count > minCountThreshold else {
                return nil
            }
            
            let rgb = rgb as! RGB

            return ColorFrequency(color: UIColor(red: CGFloat(rgb.R) / 255.0, green: CGFloat(rgb.G) / 255.0, blue: CGFloat(rgb.B) / 255.0, alpha: 1.0), count: CGFloat(count))
        }
        
        // ------
        // Step 4: Sort the remaning colors by frequency.
        // ------
        
        let sortedColorsFrequencies = filteredColorsCountMap.sorted { (lhs, rhs) -> Bool in
            return lhs.frequency > rhs.frequency
        }
        
        // ------
        // Step 5: Only keep the most frequent colors.
        // ------
        
        let maxNumberOfColors = 500
        let colorFrequencies = sortedColorsFrequencies.prefix(maxNumberOfColors)
        
        // ------
        // Step 6: Combine similar colors together.
        // ------
        
        /// The main dominant colors on the picture.
        var dominantColors = [ColorFrequency]()
        
        /// The score that needs to be met to consider two colors similar.
        let colorDifferenceScoreThreshold: CGFloat = 10.0
        
        // Combines colors that are similar.
        for colorFrequency in colorFrequencies {
            var bestMatchScore: CGFloat?
            var bestMatchColorFrequency: ColorFrequency?
            for dominantColor in dominantColors {
                let differenceScore = colorFrequency.color.difference(from: dominantColor.color, using: .CIE76).associatedValue
                if differenceScore < bestMatchScore ?? CGFloat(Int.max) {
                    bestMatchScore = differenceScore
                    bestMatchColorFrequency = dominantColor
                }
            }
            
            if let bestMatchScore = bestMatchScore, bestMatchScore < colorDifferenceScoreThreshold {
                bestMatchColorFrequency!.frequency += 1
            } else {
                dominantColors.append(colorFrequency)
            }
        }
        
        // ------
        // Step 7: Again, limit the number of colors we keep, this time drastically.
        // ------
        
        // We only keep the first few dominant colors.
        let dominantColorsMaxCount = 8
        dominantColors = Array(dominantColors.prefix(dominantColorsMaxCount))
        
        // ------
        // Step 8: Sort again on frequencies because the order may have changed because we combined colors.
        // ------
        
        dominantColors = dominantColors.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.frequency > rhs.frequency
        })
        
        // ------
        // Step 9: Calculate the frequency of colors as a percentage.
        // ------
        
        /// The total count of colors
        let dominantColorsTotalCount = dominantColors.reduce(into: 0) { (result, colorFrequency) in
            result += colorFrequency.frequency
        }
        
        dominantColors = dominantColors.map({ (colorFrequency) -> ColorFrequency in
            let percentage = (100.0 / (dominantColorsTotalCount / colorFrequency.frequency) / 100.0).rounded(.up, precision: 100)
            
            return ColorFrequency(color: colorFrequency.color, count: percentage)
        })
        
        return dominantColors
    }
    
    private func kMeansClustering(with quality: DominantColorQuality) throws -> [UIColor] {
        guard let ciImage = CIImage(image: self) else {
            throw ImageColorError.ciImageFailure
        }
        let kMeansFilter = CIFilter(name: "CIKMeans")!
        
        let clusterCount = 8

        kMeansFilter.setValue(ciImage, forKey: kCIInputImageKey)
        kMeansFilter.setValue(CIVector(cgRect: ciImage.extent), forKey: "inputExtent")
        kMeansFilter.setValue(clusterCount, forKey: "inputCount")
        kMeansFilter.setValue(quality.kMeansInputPasses, forKey: "inputPasses")
        kMeansFilter.setValue(NSNumber(value: true), forKey: "inputPerceptual")

        guard var outputImage = kMeansFilter.outputImage else {
            throw ImageColorError.outputImageFailure
        }
        
        outputImage = outputImage.settingAlphaOne(in: outputImage.extent)
        
        let context = CIContext()
        var bitmap = [UInt8](repeating: 0, count: 4 * clusterCount)
        
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4 * clusterCount, bounds: outputImage.extent, format: CIFormat.RGBA8, colorSpace: ciImage.colorSpace!)
        
        var dominantColors = [UIColor]()

        for i in 0..<clusterCount {
            let color = UIColor(red: CGFloat(bitmap[i * 4 + 0]) / 255.0, green: CGFloat(bitmap[i * 4 + 1]) / 255.0, blue: CGFloat(bitmap[i * 4 + 2]) / 255.0, alpha: CGFloat(bitmap[i * 4 + 3]) / 255.0)
            dominantColors.append(color)
        }
        
        return dominantColors
    }
    
}
