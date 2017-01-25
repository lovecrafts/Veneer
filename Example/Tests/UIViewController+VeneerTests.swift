//
//  UIViewController+VeneerTests.swift
//  Veneer
//
//  Created by Sam Watts on 25/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Veneer

class UIViewController_VeneerTests: XCTestCase {
    
    func testShowingVeneerUpdatesKeyWindow() {
        
        let originalKeyWindow = UIApplication.shared.keyWindow
        XCTAssertNotNil(originalKeyWindow)
        
        let viewController = UIViewController()
        viewController.showVeneer()
        
        let keyWindow = UIApplication.shared.keyWindow
        XCTAssertNotNil(keyWindow)
        XCTAssertEqual(UIApplication.shared.veneerWindow, keyWindow)
        XCTAssertFalse(originalKeyWindow === keyWindow)
    }
    
    func testDismissingVeneerRestoresKeyWindow() {
        
        let originalKeyWindow = UIApplication.shared.keyWindow
        XCTAssertNotNil(originalKeyWindow)
        
        let viewController = UIViewController()
        viewController.showVeneer()
        
        let dismissComplete = expectation(description: "dismiss veneer complete")
        viewController.dismissVeneer(animated: false) {
            let keyWindowAfterDismiss = UIApplication.shared.keyWindow
            
            XCTAssertNotNil(keyWindowAfterDismiss)
            XCTAssertTrue(keyWindowAfterDismiss === originalKeyWindow)
            
            dismissComplete.fulfill()
        }
        
        waitForExpectations(timeout: 1) { XCTAssertNil($0) }
    }
    
}
