//
//  CGFloatExtensionsTests.swift
//  ColorKitTests
//
//  Created by Boris Emorine on 2/26/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import XCTest
@testable import ColorKit

class CGFloatExtensionsTests: XCTestCase {

    func testRoundedWithPrecision10() {
        let sut: CGFloat = 100.39999999
        let roundedSut = sut.rounded(.toNearestOrEven, precision: 10)
        XCTAssertEqual(roundedSut, 100.4)
    }
    
    func testRoundedWithPrecision100() {
        let sut: CGFloat = 100.39999999
        let roundedSut = sut.rounded(.toNearestOrEven, precision: 100)
        XCTAssertEqual(roundedSut, 100.40)
    }
    
}
