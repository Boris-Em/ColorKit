//
//  CMYKTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 6/20/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class CMYKTests: XCTestCase {

    func testGreen() {
        let color = UIColor.green
        
        XCTAssertEqual(color.cyan, 1.0)
        XCTAssertEqual(color.magenta, 0.0)
        XCTAssertEqual(color.yellow, 1.0)
        XCTAssertEqual(color.key, 0.0)
    }
    
    func testBlue() {
        let color = UIColor.blue
        
        XCTAssertEqual(color.cyan, 1.0)
        XCTAssertEqual(color.magenta, 1.0)
        XCTAssertEqual(color.yellow, 0.0)
        XCTAssertEqual(color.key, 0.0)
    }
    
    func testWhite() {
        let color = UIColor.white
        
        XCTAssertEqual(color.cyan, 0.0)
        XCTAssertEqual(color.magenta, 0.0)
        XCTAssertEqual(color.yellow, 0.0)
        XCTAssertEqual(color.key, 0.0)
    }
    
    func testArbitrary() {
        let color = UIColor(red: 153.0 / 255.0, green: 71.0 / 255.0, blue: 206.0 / 255.0, alpha: 1.0)
        
        XCTAssertEqual(color.cyan, 0.26, accuracy: 0.01)
        XCTAssertEqual(color.magenta, 0.66, accuracy: 0.01)
        XCTAssertEqual(color.yellow, 0.0)
        XCTAssertEqual(color.key, 0.19, accuracy: 0.01)
    }
    
}
