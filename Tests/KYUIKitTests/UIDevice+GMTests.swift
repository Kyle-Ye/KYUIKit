//
//  UIDevice+KYTests.swift
//  
//
//  Created by Kyle on 2024/4/20.
//

import XCTest
import KYUIKit

final class UIDevice_KYTests: XCTestCase {
    func testAPI() {
        _ = UIDevice.ky
        _ = UIDevice.current.ky
    }
    
    func testPadCheck() {
        let device = UIDevice.current
        let idom = device.userInterfaceIdiom
        if idom == .pad {
            XCTAssertTrue(device.ky.isPad)
            XCTAssertTrue(UIDevice.ky.isPad)
        } else {
            XCTAssertFalse(device.ky.isPad)
            XCTAssertFalse(UIDevice.ky.isPad)
        }
    }
}
