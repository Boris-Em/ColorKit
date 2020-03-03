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
        
        let difference = color1.difference(from: color2, using: .euclidean).associatedValue
        XCTAssertEqual(difference, 0)
        
        let reversedDifference = color2.difference(from: color1, using: .euclidean).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testPurplePurpleEuclidean() {
        let color1 = UIColor.purple
        let color2 = UIColor.purple
        
        let difference = color1.difference(from: color2, using: .euclidean).associatedValue
        XCTAssertEqual(difference, 0)
        
        let reversedDifference = color2.difference(from: color1, using: .euclidean).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testWhiteBlackEuclidean() {
        let color1 = UIColor.white
        let color2 = UIColor.black
        
        let difference = color1.difference(from: color2, using: .euclidean).associatedValue
        XCTAssertEqual(difference, 441.67)
        
        let reversedDifference = color2.difference(from: color1, using: .euclidean).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testRandomEuclidean() {
        let color1 = UIColor(red: 0.3, green: 0.5, blue: 0.7, alpha: 1.0)
        let color2 = UIColor(red: 0.5, green: 0.1, blue: 0.2, alpha: 1.0)
        
        let difference = color1.difference(from: color2, using: .euclidean).associatedValue
        XCTAssertEqual(difference, 171.06)
        
        let reversedDifference = color2.difference(from: color1, using: .euclidean).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testCloseEuclidean() {
        let color1 = UIColor(red: 196.0 / 255.0, green: 199.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
        let color2 = UIColor(red: 171.0 / 255.0, green: 173.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0)

        let difference = color1.difference(from: color2, using: .euclidean).associatedValue
        XCTAssertEqual(difference, 36.29)

        let reversedDifference = color2.difference(from: color1, using: .euclidean).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }
    
    // MARK: - CIE76
    
    func testWhiteWhiteCIE76() {
        let color1 = UIColor.white
        let color2 = UIColor.white
        
        let difference = color1.difference(from: color2, using: .CIE76).associatedValue
        XCTAssertEqual(difference, 0)
        
        let reversedDifference = color2.difference(from: color1, using: .CIE76).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testPurplePurpleCIE76() {
        let color1 = UIColor.purple
        let color2 = UIColor.purple
        
        let difference = color1.difference(from: color2, using: .CIE76).associatedValue
        XCTAssertEqual(difference, 0)
        
        let reversedDifference = color2.difference(from: color1, using: .CIE76).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testWhiteBlackCIE76() {
        let color1 = UIColor.white
        let color2 = UIColor.black
        
        let difference = color1.difference(from: color2, using: .CIE76).associatedValue
        XCTAssertEqual(difference, 100.0)
        
        let reversedDifference = color2.difference(from: color1, using: .CIE76).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testRandomCIE76() {
        let color1 = UIColor(red: 0.3, green: 0.5, blue: 0.7, alpha: 1.0)
        let color2 = UIColor(red: 0.5, green: 0.1, blue: 0.2, alpha: 1.0)
        
        let difference = color1.difference(from: color2, using: .CIE76).associatedValue
        XCTAssertEqual(difference, 67.55)
        
        let reversedDifference = color2.difference(from: color1, using: .CIE76).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }
    
    func testCloseCIE76() {
        let color1 = UIColor(red: 196.0 / 255.0, green: 199.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
        let color2 = UIColor(red: 171.0 / 255.0, green: 173.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0)

        let difference = color1.difference(from: color2, using: .CIE76).associatedValue
        XCTAssertEqual(difference, 14.25)
        
        let reversedDifference = color2.difference(from: color1, using: .CIE76).associatedValue
        XCTAssertEqual(reversedDifference, difference)
    }

}
