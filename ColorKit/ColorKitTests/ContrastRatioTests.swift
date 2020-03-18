//
//  ContrastRatioTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 3/13/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class ContrastRatioTests: XCTestCase {

    func testBlackWhite() {
        let color = UIColor.white
        let backgroundColor = UIColor.black
        let contrastRatioResult = color.contrastRatio(with: backgroundColor)
        XCTAssertEqual(contrastRatioResult.associatedValue, 21.0)
    }
    
    func testWhiteBlack() {
        let color = UIColor.black
        let backgroundColor = UIColor.white
        let contrastRatioResult = color.contrastRatio(with: backgroundColor)
        XCTAssertEqual(contrastRatioResult.associatedValue, 21.0)
    }
    
    func testOrangeOrangeClose() {
        let color = UIColor(red: 243.0 / 255.0, green: 120.0 / 255.0, blue: 9.0 / 255.0, alpha: 1.0)
        let backgroundColor = UIColor(red: 222.0 / 255.0, green: 100.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
        let contrastRatioResult = color.contrastRatio(with: backgroundColor)
        XCTAssertEqual(contrastRatioResult.associatedValue, 1.26)
    }
    
    func testOrangeOrange() {
        let color = UIColor(red: 243.0 / 255.0, green: 120.0 / 255.0, blue: 9.0 / 255.0, alpha: 1.0)
        let backgroundColor = UIColor(red: 243.0 / 255.0, green: 120.0 / 255.0, blue: 9.0 / 255.0, alpha: 1.0)
        let contrastRatioResult = color.contrastRatio(with: backgroundColor)
        XCTAssertEqual(contrastRatioResult.associatedValue, 1.0)
    }
    
    func testGreenPurple() {
        let green = UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        let blue = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        let contrastRatioResult = green.contrastRatio(with: blue)
        XCTAssertEqual(contrastRatioResult.associatedValue, 6.27)
    }

}
