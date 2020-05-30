//
//  DominantColorQualityTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 5/30/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class DominantColorQualityTests: XCTestCase {
    
    /// It should return the exact same size (original size) if the quality is set to best.
    func testBestQuality() {
        let quality = UIImage.DominantColorQuality.best
        let originalSize = CGSize(width: CGFloat.random(in: 0...10000), height: CGFloat.random(in: 0...10000))
        let targetSize = quality.targetSize(for: originalSize)
        
        XCTAssertEqual(targetSize, originalSize)
    }
    
    /// It should return the exact same size (original size) if the original size is smaller than the size we're trying to reach.
    func testLowerArea() {
        let quality = UIImage.DominantColorQuality.fair
        let originalSize = CGSize(width: 1, height: 1)
        let targetSize = quality.targetSize(for: originalSize)
        
        XCTAssertEqual(targetSize, originalSize)
    }
    
}
