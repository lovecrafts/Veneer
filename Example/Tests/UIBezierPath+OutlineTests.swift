//
//  UIBezierPath+OutlineTests.swift
//  Veneer
//
//  Created by Sam Watts on 10/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Veneer

class UIBezierPath_OutlineTests: XCTestCase {
    
    func testPathWithEmptyArray() {
        let sut = UIBezierPath(outliningViewFrames: [])
        
        XCTAssertEqual(sut, UIBezierPath())
    }
    
    func testPathWithSingleRect() {
        
        let rect = CGRect(x: 50, y: 50, width: 100, height: 100)
        let sut = UIBezierPath(outliningViewFrames: [rect])
        
        XCTAssertEqual(sut, UIBezierPath(rect: rect))
    }
    
    func testPathWithMultipleIntersectingRects() {
        
        let a = CGRect(x: 50, y: 50, width: 50, height: 50)
        let b = CGRect(x: 75, y: 60, width: 50, height: 20)
        
        let sut = UIBezierPath(outliningViewFrames: [a, b])
        
        let expectedPath = UIBezierPath()
        expectedPath.move(to: CGPoint(x: 50, y: 50))
        expectedPath.addLine(to: CGPoint(x: 100, y: 50))
        expectedPath.addLine(to: CGPoint(x: 100, y: 60))
        expectedPath.addLine(to: CGPoint(x: 125, y: 60))
        expectedPath.addLine(to: CGPoint(x: 125, y: 60)) //repeated because this is where the top and bottom parts of the algorithm will overlap
        expectedPath.addLine(to: CGPoint(x: 125, y: 80))
        expectedPath.addLine(to: CGPoint(x: 100, y: 80))
        expectedPath.addLine(to: CGPoint(x: 100, y: 100))
        expectedPath.addLine(to: CGPoint(x: 50, y: 100))
        expectedPath.close()
        
        XCTAssertEqual(sut, expectedPath)
    }
    
    func testPathWithMultipleNonIntersectingRects() {
        
        let a = CGRect(x: 50, y: 50, width: 50, height: 50)
        let b = CGRect(x: 200, y: 200, width: 50, height: 50)
        
        let sut = UIBezierPath(outliningViewFrames: [a, b])
        
        let expectedPath = UIBezierPath()
        
        expectedPath.move(to: CGPoint(x: 50, y: 50))
        expectedPath.addLine(to: CGPoint(x: 100, y: 50))
        expectedPath.addLine(to: CGPoint(x: 100, y: 200))
        expectedPath.addLine(to: CGPoint(x: 200, y: 200))
        expectedPath.addLine(to: CGPoint(x: 250, y: 200))
        expectedPath.addLine(to: CGPoint(x: 250, y: 200)) //repeated because this is where the top and bottom parts of the algorithm will overlap
        expectedPath.addLine(to: CGPoint(x: 250, y: 250))
        expectedPath.addLine(to: CGPoint(x: 200, y: 250))
        expectedPath.addLine(to: CGPoint(x: 200, y: 100))
        expectedPath.addLine(to: CGPoint(x: 100, y: 100))
        expectedPath.addLine(to: CGPoint(x: 50, y: 100))
        expectedPath.close()
        
        XCTAssertEqual(sut, expectedPath)
    }
    
}
