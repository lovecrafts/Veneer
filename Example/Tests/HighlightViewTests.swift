//
//  HighlightViewTests.swift
//  Veneer
//
//  Created by Sam Watts on 02/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Veneer

class HighlightViewTests: XCTestCase {
    
    let testHighlight = Highlight(viewType: .view(view: UIView()), borderInsets: UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4), lineDashColor: .green, lineDashPattern: [1, 2, 3, 4], lineDashWidth: 10)
    
    func testBorderLayerIsInitialisedCorrectly() {
        let sut = HighlightView(highlight: testHighlight)
        
        let borderLayer = sut.borderLayer
        XCTAssertEqual(borderLayer.strokeColor, testHighlight.lineDashColor.cgColor)
        XCTAssertNotNil(borderLayer.lineDashPattern)
        XCTAssertEqual(borderLayer.lineDashPattern ?? [], testHighlight.lineDashPattern as [NSNumber])
        XCTAssertEqual(borderLayer.lineWidth, testHighlight.lineDashWidth)
    }
    
    func testBorderLayerMaskIsSetupCorrectlyOnLayout() {
        let sut = HighlightView(highlight: testHighlight)
        sut.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        sut.layoutSublayers(of: sut.layer)
        
        XCTAssertEqual(sut.borderLayer.frame, CGRect(x: 2.5, y: 2.5, width: 190, height: 190))
        XCTAssertNotNil(sut.borderLayer.path)
        XCTAssertEqual(sut.borderLayer.path ?? UIBezierPath(rect: .zero).cgPath, UIBezierPath(rect: sut.borderLayer.frame).cgPath)
    }
    
}
