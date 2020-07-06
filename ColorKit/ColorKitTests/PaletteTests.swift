//
//  PaletteTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 7/6/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class PaletteTests: XCTestCase {

    func testPaletteNoColors() {
        XCTAssertNil(ColorPalette(colors: []))
    }
    
    func testPaletteOneColor() {
        XCTAssertNil(ColorPalette(colors: [.green]))
    }
    
    func testPaletteSameColors() {
        XCTAssertNil(ColorPalette(colors: [.green, .green, .green, .green]))
    }
    
    func testPaletteBlackWhiteColors() {
        let colorPalette = ColorPalette(colors: [.black, .white])
        XCTAssertEqual(colorPalette?.background, .black)
        XCTAssertEqual(colorPalette?.primary, .white)
        XCTAssertNil(colorPalette?.secondary)
    }
    
    func testPaletteBlackWhiteColorsBright() {
        let colorPalette = ColorPalette(colors: [.black, .white], darkBackground: false)
        XCTAssertEqual(colorPalette?.background, .white)
        XCTAssertEqual(colorPalette?.primary, .black)
        XCTAssertNil(colorPalette?.secondary)
    }
    
    func testCloseColors() {
        XCTAssertNil(ColorPalette(colors: [.blue, UIColor(red: 0, green: 0, blue: 0.8, alpha: 1.0)]))
    }
    
    func testRealUseCase() {
        let darkBlue = UIColor(red: 0.0 / 255.0, green: 120.0 / 255.0, blue: 190.0 / 255.0, alpha: 1.0)
        let brightBlue = UIColor(red: 110.0 / 255.0, green: 178.0 / 255.0, blue: 200.0 / 255.0, alpha: 1.0)
        let orange = UIColor(red: 203.0 / 255.0, green: 179.0 / 255.0, blue: 121.0 / 255.0, alpha: 1.0)
        let colorPalette = ColorPalette(colors: [darkBlue, brightBlue, orange], ignoreContrastRatio: true)
        XCTAssertEqual(colorPalette?.background, darkBlue)
        XCTAssertEqual(colorPalette?.primary, orange)
        XCTAssertEqual(colorPalette?.secondary, brightBlue)
    }
    
    func testRealUseCase2() {
        let red = UIColor(red: 255.0 / 255.0, green: 21.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0)
        let darkBlue = UIColor(red: 76.0 / 255.0, green: 101.0 / 255.0, blue: 122.0 / 255.0, alpha: 1.0)
        let white = UIColor.white
        let colorPalette = ColorPalette(colors: [red, darkBlue, white], darkBackground: false)
        XCTAssertEqual(colorPalette?.background, white)
        XCTAssertEqual(colorPalette?.primary, darkBlue)
        XCTAssertEqual(colorPalette?.secondary, red)
    }
    
}
