//
//  VeneerOverlayViewTests.swift
//  Veneer
//
//  Created by Sam Watts on 02/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Veneer

class StubbedVeneerOverlayView: VeneerOverlayView {
    
    var highlightFramePassedToLayoutSubviews: CGRect?
    override func layoutSubviews(withHighlightViewFrame highlightFrame: CGRect) {
        highlightFramePassedToLayoutSubviews = highlightFrame
    }
}

class VeneerOverlayViewTests: XCTestCase {
    
    func testCustomLayoutSubviewsIsCalledFromLayoutSubviewsWhenFrameIsNonNil() {
        let sut = StubbedVeneerOverlayView()
        sut.highlightViewFrame = .zero
        
        sut.layoutSubviews()
        
        XCTAssertNotNil(sut.highlightFramePassedToLayoutSubviews)
        XCTAssertEqual(sut.highlightFramePassedToLayoutSubviews, .zero)
    }
    
    func testCustomLayoutSubviewsIsNotCalledFromLayoutSubviewsWhenFrameIsNil() {
        let sut = StubbedVeneerOverlayView()
        sut.highlightViewFrame = nil
        
        sut.layoutSubviews()
        
        XCTAssertNil(sut.highlightFramePassedToLayoutSubviews)
    }
    
}
