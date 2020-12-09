//
//  NameTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 12/9/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
import ColorKit

class NameTests: XCTestCase {

    func testPrimaryExact() {
        let color = UIColor.blue
        XCTAssertEqual(color.name(), "blue")
    }
    
    func testSecondaryExact() {
        let color = UIColor.purple
        XCTAssertEqual(color.name(), "violet")
    }
    
    func testTertiaryExact() {
        let color = UIColor(red: 0.5, green: 1.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(color.name(), "chartreuse")
    }
    
    func testClose() {
        let color = UIColor(red: 0.9, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(color.name(), "red")
    }
    
    func testBlack() {
        let color = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(color.name(), "black")
    }
    
    func testWhite() {
        let color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        XCTAssertEqual(color.name(), "white")
    }
    
    func testGray() {
        let color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        XCTAssertEqual(color.name(), "gray")
    }
    
    func testDarkGray() {
        let color = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        XCTAssertEqual(color.name(), "gray")
    }
    
    func testLightGray() {
        let color = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        XCTAssertEqual(color.name(), "gray")
    }
    
    func testRandom() {
        let color = UIColor.random()
        XCTAssertNotNil(color.name())
    }
    
}
