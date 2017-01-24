//
//  UIApplication+WindowStorageTests.swift
//  Veneer
//
//  Created by Sam Watts on 25/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Veneer

class UIApplication_WindowStorageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        //reset veneer window storage
        UIApplication.shared.veneerWindow = nil
    }
    
    func testSettingVeneerWindowOnApplicationStoresValue() {
        let testWindow = UIWindow(frame: .zero)
        
        let sut = UIApplication.shared
        sut.veneerWindow = testWindow
        
        let storedValue = sut.veneerWindow
        
        XCTAssertTrue(storedValue === testWindow)
    }
    
    func testClearingVeneerWindowRemovesStoredValue() {
        let testWindow = UIWindow(frame: .zero)
        
        let sut = UIApplication.shared
        sut.veneerWindow = testWindow
        
        XCTAssertTrue(sut.veneerWindow === testWindow)
        
        sut.veneerWindow = nil
        
        XCTAssertNil(sut.veneerWindow)
    }
    
}
