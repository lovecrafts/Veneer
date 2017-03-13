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
        viewController.showVeneer(withHighlight: Highlight(viewType: .view(view: UIView())))
        
        let keyWindow = UIApplication.shared.keyWindow
        XCTAssertNotNil(keyWindow)
        XCTAssertEqual(UIApplication.shared.veneerWindow, keyWindow)
        XCTAssertFalse(originalKeyWindow === keyWindow)
    }
    
    func testDismissingVeneerRestoresKeyWindow() {
        
        let originalKeyWindow = UIApplication.shared.keyWindow
        XCTAssertNotNil(originalKeyWindow)
        
        let viewController = UIViewController()
        viewController.showVeneer(withHighlight: Highlight(viewType: .view(view: UIView())))
        
        let dismissComplete = expectation(description: "dismiss veneer complete")
        viewController.dismissVeneer(animated: false) { _ in 
            let keyWindowAfterDismiss = UIApplication.shared.keyWindow
            
            XCTAssertNotNil(keyWindowAfterDismiss)
            XCTAssertTrue(keyWindowAfterDismiss === originalKeyWindow)
            
            dismissComplete.fulfill()
        }
        
        waitForExpectations(timeout: 1) { XCTAssertNil($0) }
    }
    
    func testDismissingVeneerWithoutAlreadyPresentingDoesNothing() {
        
        let viewController = UIViewController()
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        viewController.dismissVeneer(animated: false) { _ in
            dispatchGroup.leave()
        }
        
        let result = dispatchGroup.wait(timeout: .now() + 1)
        switch result {
        case .success:
            XCTFail("Dismiss should never have been called")
        case .timedOut:
            break
        }
    }
    
    func testDismissTypeDescriptions() {
        let types: [DismissType] = [
            .programmatic,
            .tapToDismiss,
            .tapOnHighlight
        ]
        
        let expectedDescriptions = [
            "Dismissed programmatically",
            "Tapped on background / close button",
            "Tapped on highlighted view(s)"
        ]
        
        XCTAssertEqual(types.map { $0.description }, expectedDescriptions)
    }
    
}
