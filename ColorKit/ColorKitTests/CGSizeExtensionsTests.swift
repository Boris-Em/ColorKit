//
//  CGSizeExtensionsTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 5/30/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class CGSizeExtensionsTests: XCTestCase {

    /// A simple test with hard coded values where the target size is smaller than the original size.
    func testSimpleSmaller() {
        let originalSize = CGSize(width: 100, height: 100)
        let targetSize = originalSize.transformToFit(in: 100)
        
        let expectedSize = CGSize(width: 10, height: 10)
        XCTAssertEqual(targetSize, expectedSize)
    }
    
    /// A simple test with hard coded values where the target size is greater than the original size.
    func testSimpleGreater() {
        let originalSize = CGSize(width: 10, height: 10)
        let targetSize = originalSize.transformToFit(in: 10_000)
        
        let expectedSize = CGSize(width: 100, height: 100)
        XCTAssertEqual(targetSize, expectedSize)
    }
    
    /// It should return a target size with the expected area and keeping the same size ratio, when the target area is smaller than the original area.
    func testSmaller() {
        let originalSize = CGSize(width: 1024, height: 800)
        let targetArea: CGFloat = originalSize.area / CGFloat.random(in: 1...4)
        let targetSize = originalSize.transformToFit(in: targetArea)
        
        XCTAssertEqual(originalSize.width / originalSize.height, targetSize.width / targetSize.height, accuracy: 0.01)
        XCTAssertEqual(targetArea, targetSize.width * targetSize.height, accuracy: 0.01)
    }
    
    /// It should return a target size with the expected area and keeping the same size ratio, when the target area is greater than the original area.
    func testGreater() {
        let originalSize = CGSize(width: 1024, height: 800)
        let targetArea: CGFloat = originalSize.area * CGFloat.random(in: 1...4)
        let targetSize = originalSize.transformToFit(in: targetArea)
        
        XCTAssertEqual(originalSize.width / originalSize.height, targetSize.width / targetSize.height, accuracy: 0.01)
        XCTAssertEqual(targetArea, targetSize.width * targetSize.height, accuracy: 0.01)
    }
    
    /// It should return a target size with the expected area and keeping the same size ratio.
    func testRandom() {
        let originalSize = CGSize(width: CGFloat.random(in: 0...100000), height: CGFloat.random(in: 0...100000))
        let targetArea: CGFloat = originalSize.area * CGFloat.random(in: 0...2)
        let targetSize = originalSize.transformToFit(in: targetArea)

        XCTAssertEqual(originalSize.width / originalSize.height, targetSize.width / targetSize.height, accuracy: 0.01)
        XCTAssertEqual(targetArea, targetSize.width * targetSize.height, accuracy: 0.01)
    }

}
