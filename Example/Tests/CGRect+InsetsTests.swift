//
//  CGRect+InsetsTests.swift
//  Veneer
//
//  Created by Sam Watts on 02/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Veneer

class CGRect_InsetsTests: XCTestCase {
    
    func testInsetIsAppliedCorrectly() {
        let sut = CGRect(x: 100, y: 100, width: 200, height: 200)
        let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
        
        let insetRect = sut.applying(insets: insets)
        
        XCTAssertEqual(insetRect, CGRect(x: 110, y: 105, width: 170, height: 180))
    }
    
    func testInvalidHorizontalInsetsAreIgnored() {
        let sut = CGRect(x: 100, y: 100, width: 200, height: 200)
        let insets = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 1000) //insets beyond width
        
        let insetRect = sut.applying(insets: insets)
        
        XCTAssertEqual(insetRect, sut)
    }
    
    func testInvalidVerticalInsetsAreIgnored() {
        let sut = CGRect(x: 100, y: 100, width: 200, height: 200)
        let insets = UIEdgeInsets(top: 1000, left: 0, bottom: 1000, right: 0) //insets beyond height
        
        let insetRect = sut.applying(insets: insets)
        
        XCTAssertEqual(insetRect, sut)
    }
    
}
