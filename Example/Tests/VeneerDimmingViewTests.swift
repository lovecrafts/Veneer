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
        let sut = VeneerDimmingView(inverseMaskViews: [])
        
        let mask = sut.layer.mask
        XCTAssertNotNil(mask)
        
        let shapeMask = mask as? CAShapeLayer
        XCTAssertNotNil(shapeMask)
        XCTAssertEqual(shapeMask?.fillRule, kCAFillRuleEvenOdd)
    }
    
    func testSettingsInverseMaskViewCallsSetsNeedsLayout() {
        let sut = StubbedVeneerDimmingView(inverseMaskViews: [])
        
        XCTAssertFalse(sut.setNeedsLayoutCalled)
        sut.inverseMaskViews = [UIView()]
        XCTAssertTrue(sut.setNeedsLayoutCalled)
    }
    
    func testSettingsMaskInsetsCallsSetsNeedsLayout() {
        let sut = StubbedVeneerDimmingView(inverseMaskViews: [])
        
        XCTAssertFalse(sut.setNeedsLayoutCalled)
        sut.maskInsets = .zero
        XCTAssertTrue(sut.setNeedsLayoutCalled)
    }
    
    func testLayoutSetsCorrectMaskWhenMaskViewIsSet() {
        let maskView = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let sut = VeneerDimmingView(inverseMaskViews: [maskView])
        sut.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        sut.layoutSubviews()
        
        let shapeMask = sut.layer.mask as? CAShapeLayer
        XCTAssertNotNil(shapeMask?.path)
        
        let expectedPath = UIBezierPath()
        expectedPath.append(UIBezierPath(rect: sut.bounds))
        expectedPath.append(UIBezierPath(roundedRect: maskView.frame, cornerRadius: 0))
        
        XCTAssertEqual(shapeMask?.path, expectedPath.cgPath)
    }
    
    func testLayoutSetsCorrectMaskWhenMultipleMaskViewsAreSet() {
        let maskView1 = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let maskView2 = UIView(frame: CGRect(x: 50, y: 60, width: 60, height: 60))
        let sut = VeneerDimmingView(inverseMaskViews: [maskView1, maskView2])
        sut.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        sut.layoutSubviews()
        
        let shapeMask = sut.layer.mask as? CAShapeLayer
        XCTAssertNotNil(shapeMask?.path)
        
        let expectedPath = UIBezierPath()
        expectedPath.append(UIBezierPath(rect: sut.bounds))
        expectedPath.append(UIBezierPath(outliningViewFrames: [maskView1.frame, maskView2.frame]))
        
        XCTAssertEqual(shapeMask?.path, expectedPath.cgPath)
    }
    
    func testLayoutSetsCorrectMaskWhenNoMaskView() {
        let sut = VeneerDimmingView(inverseMaskViews: [])
        sut.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        sut.layoutSubviews()
        
        let shapeMask = sut.layer.mask as? CAShapeLayer
        XCTAssertNotNil(shapeMask?.path)
        
        let expectedPath = UIBezierPath()
        expectedPath.append(UIBezierPath(rect: sut.bounds))
        
        XCTAssertEqual(shapeMask?.path, expectedPath.cgPath)
    }
    
}
