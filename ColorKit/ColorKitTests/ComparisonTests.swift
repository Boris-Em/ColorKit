//
//  ComparisonTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 2/24/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class ComparisonTests: XCTestCase {
    
    // MARK: - Euclidean
    
    func testWhiteWhiteEuclidean() {
        let color1 = UIColor.white
        let color2 = UIColor.white
        
        let difference = color1.difference(from: color2, using: .euclidean)
        XCTAssertEqual(difference, 0)
        
        let reversedDifference = color2.difference(from: color1, using: .euclidean)
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testPurplePurpleEuclidean() {
        let color1 = UIColor.purple
        let color2 = UIColor.purple
        
        let difference = color1.difference(from: color2, using: .euclidean)
        XCTAssertEqual(difference, 0)
        
        let reversedDifference = color2.difference(from: color1, using: .euclidean)
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testWhiteBlackEuclidean() {
        let color1 = UIColor.white
        let color2 = UIColor.black
        
        let difference = color1.difference(from: color2, using: .euclidean)
        XCTAssertEqual(difference, 441.6729559300637)
        
        let reversedDifference = color2.difference(from: color1, using: .euclidean)
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testRandomEuclidean() {
        let color1 = UIColor(red: 0.3, green: 0.5, blue: 0.7, alpha: 1.0)
        let color2 = UIColor(red: 0.5, green: 0.1, blue: 0.2, alpha: 1.0)
        
        let difference = color1.difference(from: color2, using: .euclidean)
        XCTAssertEqual(difference, 171.05920027873393)
        
        let reversedDifference = color2.difference(from: color1, using: .euclidean)
        XCTAssertEqual(reversedDifference, difference)
    }

}
