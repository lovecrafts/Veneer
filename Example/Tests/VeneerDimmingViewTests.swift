//
//  VeneerDimmingViewTests.swift
//  Veneer
//
//  Created by Sam Watts on 02/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Veneer

class StubbedVeneerDimmingView: VeneerDimmingView {
    
    var setNeedsLayoutCalled: Bool = false
    override func setNeedsLayout() {
        setNeedsLayoutCalled = true
    }
}

class VeneerDimmingViewTests: XCTestCase {
    
    func testMaskIsAddedToLayer() {
        let sut = VeneerDimmingView(inverseMaskView: nil)
        
        let mask = sut.layer.mask
        XCTAssertNotNil(mask)
        
        let shapeMask = mask as? CAShapeLayer
        XCTAssertNotNil(shapeMask)
        XCTAssertEqual(shapeMask?.fillRule, kCAFillRuleEvenOdd)
    }
    
    func testSettingsInverseMaskViewCallsSetsNeedsLayout() {
        let sut = StubbedVeneerDimmingView(inverseMaskView: nil)
        
        XCTAssertFalse(sut.setNeedsLayoutCalled)
        sut.inverseMaskView = UIView()
        XCTAssertTrue(sut.setNeedsLayoutCalled)
    }
    
    func testSettingsMaskInsetsCallsSetsNeedsLayout() {
        let sut = StubbedVeneerDimmingView(inverseMaskView: nil)
        
        XCTAssertFalse(sut.setNeedsLayoutCalled)
        sut.maskInsets = .zero
        XCTAssertTrue(sut.setNeedsLayoutCalled)
    }
    
    func testLayoutSetsCorrectMaskWhenMaskViewIsSet() {
        let maskView = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let sut = VeneerDimmingView(inverseMaskView: maskView)
        sut.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        sut.layoutSubviews()
        
        let shapeMask = sut.layer.mask as? CAShapeLayer
        XCTAssertNotNil(shapeMask?.path)
        
        let expectedPath = CGMutablePath()
        expectedPath.addRect(sut.bounds)
        expectedPath.addRect(maskView.frame)
        
        XCTAssertEqual(shapeMask?.path, expectedPath)
    }
    
    func testLayoutSetsCorrectMaskWhenNoMaskView() {
        let sut = VeneerDimmingView(inverseMaskView: nil)
        sut.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        sut.layoutSubviews()
        
        let shapeMask = sut.layer.mask as? CAShapeLayer
        XCTAssertNotNil(shapeMask?.path)
        
        let expectedPath = CGMutablePath()
        expectedPath.addRect(sut.bounds)
        
        XCTAssertEqual(shapeMask?.path, expectedPath)
    }
    
}
