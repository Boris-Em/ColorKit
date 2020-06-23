//
//  DominantColorsTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 5/19/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class DominantColorsTests: XCTestCase {
    
    func testGreenImage() throws {
        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "Green_Square.jpg", in: bundle, compatibleWith: nil)!
        let dominantColors = try image.dominantColorFrequencies(with: .best)
        
        XCTAssertEqual(dominantColors.count, 1)
        guard let distance = dominantColors.first?.color.difference(from: UIColor.green) else {
            XCTFail("Could not get distance from dominant color.")
            return
        }
        XCTAssertLessThan(distance.associatedValue, AverageColorTests.tolerance)
        XCTAssertEqual(dominantColors.first?.frequency, 1.0)
    }
    
    func testBlackWhiteImage() throws {
        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "Black_White_Square.jpg", in: bundle, compatibleWith: nil)!
        let colorFrequencies = try image.dominantColorFrequencies(with: .best)
        let dominantColors = colorFrequencies.map({ $0.color })

        XCTAssertEqual(dominantColors.count, 2)
        XCTAssertTrue(dominantColors.contains(UIColor(red: 0, green: 0, blue: 0, alpha: 1)))
        XCTAssertTrue(dominantColors.contains(UIColor(red: 1, green: 1, blue: 1, alpha: 1)))
        verifySorted(colorsFrequencies: colorFrequencies)
        
        XCTAssertEqual(colorFrequencies.first?.frequency, 0.5)
        XCTAssertEqual(colorFrequencies[1].frequency, 0.5)
    }
    
    func testRedBlueGreenImage() throws {
        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "Red_Green_Blue.png", in: bundle, compatibleWith: nil)!
        let colorFrequencies = try image.dominantColorFrequencies(with: .best)
        let dominantColors = colorFrequencies.map({ $0.color })

        XCTAssertEqual(dominantColors.count, 3)
        XCTAssertTrue(dominantColors.contains(UIColor(red: 1, green: 0, blue: 0, alpha: 1)))
        XCTAssertTrue(dominantColors.contains(UIColor(red: 0, green: 1, blue: 0, alpha: 1)))
        XCTAssertTrue(dominantColors.contains(UIColor(red: 0, green: 0, blue: 1, alpha: 1)))
        verifySorted(colorsFrequencies: colorFrequencies)
    }
    
    func testRedBlueGreenBlack() throws {
        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "Red_Green_Blue_Black_Mini.png", in: bundle, compatibleWith: nil)!
        let colorFrequencies = try image.dominantColorFrequencies(with: .best)
        let dominantColors = colorFrequencies.map({ $0.color })

        XCTAssertEqual(dominantColors.count, 4)
        XCTAssertTrue(dominantColors.contains(UIColor(red: 0, green: 0, blue: 0, alpha: 1)))
        XCTAssertTrue(dominantColors.contains(UIColor(red: 1, green: 0, blue: 0, alpha: 1)))
        XCTAssertTrue(dominantColors.contains(UIColor(red: 0, green: 1, blue: 0, alpha: 1)))
        XCTAssertTrue(dominantColors.contains(UIColor(red: 0, green: 0, blue: 1, alpha: 1)))
        verifySorted(colorsFrequencies: colorFrequencies)
    }
    
    func testRedBlueGreenRandom() throws {
        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "Red_Green_Blue_Random_Mini.png", in: bundle, compatibleWith: nil)!
        let colorFrequencies = try image.dominantColorFrequencies(with: .best)
        let dominantColors = colorFrequencies.map({ $0.color })
        
        XCTAssertTrue(dominantColors.contains(UIColor(red: 1, green: 0, blue: 0, alpha: 1)))
        XCTAssertTrue(dominantColors.contains(UIColor(red: 0, green: 1, blue: 0, alpha: 1)))
        XCTAssertTrue(dominantColors.contains(UIColor(red: 0, green: 0, blue: 1, alpha: 1)))
        verifySorted(colorsFrequencies: colorFrequencies)
    }
    
    func verifySorted(colorsFrequencies: [ColorFrequency]) {
        var previousCount: CGFloat?
        
        colorsFrequencies.forEach { (colorFrequency) in
            guard let oldCount = previousCount else {
                previousCount = colorFrequency.frequency
                return
            }
            
            if oldCount < colorFrequency.frequency {
                XCTFail("The order of the color frenquecy is not correct.")
            }
            
            previousCount = colorFrequency.frequency
        }
    }
    
}
