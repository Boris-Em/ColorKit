//
//  HexTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 2/27/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class HexTests: XCTestCase {
    
    private let blackHex = "#000000"
    private let whiteHex = "#ffffff"
    private let redHex = "#ff0000"
    private let darkGreen = "#32a852"
    private let lightGreen = "#43ff64d9"

    // Init
    
    func testInitBlack() {
        let color = UIColor(hex: blackHex)!
        XCTAssertEqual(color.red, 0)
        XCTAssertEqual(color.green, 0)
        XCTAssertEqual(color.blue, 0)
        XCTAssertEqual(color.alpha, 1)
    }
    
    func testInitWhite() {
        let color = UIColor(hex: whiteHex)!
        XCTAssertEqual(color.red, 1)
        XCTAssertEqual(color.green, 1)
        XCTAssertEqual(color.blue, 1)
        XCTAssertEqual(color.alpha, 1)
    }
    
    func testInitRed() {
        let color = UIColor(hex: redHex)!
        XCTAssertEqual(color.red, 255.0 / 255.0)
        XCTAssertEqual(color.green, 0.0 / 255.0)
        XCTAssertEqual(color.blue, 0.0 / 255.0)
        XCTAssertEqual(color.alpha, 1)
    }
    
    func testInitDarkGreen() {
        let color = UIColor(hex: darkGreen)!
        XCTAssertEqual(color.red, 50.0 / 255.0)
        XCTAssertEqual(color.green, 168.0 / 255.0)
        XCTAssertEqual(color.blue, 82.0 / 255.0)
        XCTAssertEqual(color.alpha, 1)
    }
    
    func testInitLightGreen() {
        let color = UIColor(hex: lightGreen)!
        XCTAssertEqual(color.red, 67.0 / 255.0)
        XCTAssertEqual(color.green, 255.0 / 255.0)
        XCTAssertEqual(color.blue, 100.0 / 255.0)
        XCTAssertEqual(color.alpha, 0.85, accuracy: 0.001)
    }
    
    // hex
    
    func testHexBlack() {
        let color = UIColor.black
        XCTAssertEqual(color.hex, blackHex)
    }
    
    func testHexWhite() {
        let color = UIColor.white
        XCTAssertEqual(color.hex, whiteHex)
    }
    
    func testHexRed() {
        let color = UIColor.red
        XCTAssertEqual(color.hex, redHex)
    }
    
    func testHexDarkGreen() {
        let color = UIColor(red: 50.0 / 255.0, green: 168.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0)
        XCTAssertEqual(color.hex, darkGreen)
    }
    
}
