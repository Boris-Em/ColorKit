//
//  RelativeLuminanceTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 3/13/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class RelativeLuminanceTests: XCTestCase {

    func testWhite() {
        let color = UIColor.white
        XCTAssertEqual(color.relativeLuminance, 1.0)
    }
    
    func testBlack() {
        let color = UIColor.black
        XCTAssertEqual(color.relativeLuminance, 0.0)
    }
    
    func testOrange() {
        let color = UIColor(red: 98.0 / 255.0, green: 44.0 / 255.0, blue: 8.0 / 255.0, alpha: 1.0)
        XCTAssertEqual(color.relativeLuminance, 0.044)
    }
    
    func testPurple() {
        let color = UIColor(red: 120 / 255.0, green: 90.0 / 255.0, blue: 200.0 / 255.0, alpha: 1.0)
        XCTAssertEqual(color.relativeLuminance, 0.155)
    }
    
}
