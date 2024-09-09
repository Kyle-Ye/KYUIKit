//
//  UIColor+KYTests.swift
//
//
//  Created by Kyle on 2024/4/24.
//

import XCTest
import KYUIKit

final class UIColor_KYTests: XCTestCase {
    func testAPI() {
        _ = UIColor.ky
        _ = UIColor.clear.ky
    }
    
    func testHexInit() {
        XCTAssertEqual(UIColor.ky.hex("#FFFFFF"), UIColor(red: 1, green: 1, blue: 1, alpha: 1))
        XCTAssertEqual(UIColor.ky.hex("#0xFFFFFF"), UIColor(red: 1, green: 1, blue: 1, alpha: 1))
        XCTAssertEqual(UIColor.ky.hex("FFFFFF"), UIColor(red: 1, green: 1, blue: 1, alpha: 1))
        XCTAssertEqual(UIColor.ky.hex("#0xFFFFFF00"), UIColor(red: 1, green: 1, blue: 1, alpha: 0))
        XCTAssertEqual(UIColor.ky.hex("#00FFFFFF", format: .argb), UIColor(red: 1, green: 1, blue: 1, alpha: 0))
        
        XCTAssertEqual(UIColor.ky.hex("#00FFFF"), UIColor(red: 0, green: 1, blue: 1, alpha: 1))
        XCTAssertEqual(UIColor.ky.hex("#FF00FF"), UIColor(red: 1, green: 0, blue: 1, alpha: 1))
        XCTAssertEqual(UIColor.ky.hex("#FFFF00"), UIColor(red: 1, green: 1, blue: 0, alpha: 1))
    }
}
