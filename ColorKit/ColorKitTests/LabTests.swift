//
//  LabTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 2/26/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest

class LabTests: XCTestCase {

    func testGreen() {
        let color = UIColor.green
        
        XCTAssertEqual(color.L, 87.74)
        XCTAssertEqual(color.a, -86.18)
        XCTAssertEqual(color.b, 83.18)
    }
    
    func testWhite() {
        let color = UIColor.white
        
        XCTAssertEqual(color.L, 100.0)
        XCTAssertEqual(color.a, 0.01)
        XCTAssertEqual(color.b, -0.01)
    }
    
    func testArbitrary() {
        let color = UIColor(red: 129.0 / 255.0, green: 200.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
        
        XCTAssertEqual(color.L, 73.55)
        XCTAssertEqual(color.a, -46.45)
        XCTAssertEqual(color.b, 72.04)
    }
    
}
