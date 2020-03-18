//
//  ComplementaryColorTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 3/18/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
import ColorKit

class ComplementaryColorTests: XCTestCase {

    func testBlack() {
        let black = UIColor.black
        let complementaryColor = black.complementaryColor
        XCTAssertEqual(complementaryColor, UIColor(red: 1, green: 1, blue: 1, alpha: 1.0))
    }
    
    func testWhite() {
        let white = UIColor.white
        let complementaryColor = white.complementaryColor
        XCTAssertEqual(complementaryColor, UIColor(red: 0, green: 0, blue: 0, alpha: 1.0))
    }
    
    func testBlue() {
        let blue = UIColor.blue
        let complementaryColor = blue.complementaryColor
        XCTAssertEqual(complementaryColor, UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 0, alpha: 1.0))
    }
    
    func testYellow() {
        let yellow = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 0, alpha: 1.0)
        let complementaryColor = yellow.complementaryColor
        XCTAssertEqual(complementaryColor, UIColor.blue)
    }
    
    func testRed() {
        let red = UIColor.red
        let complementaryColor = red.complementaryColor
        XCTAssertEqual(complementaryColor, UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0))
    }
        
}
