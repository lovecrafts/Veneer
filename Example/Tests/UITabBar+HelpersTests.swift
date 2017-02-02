//
//  UITabBar+HelpersTests.swift
//  Veneer
//
//  Created by Sam Watts on 02/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Veneer

class UITabBar_HelpersTests: XCTestCase {
    
    func testNilIsReturnedWhenTabBarHasNoItems() {
        let sut = UITabBar()
        let barItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 12)
        
        XCTAssertNil(sut.view(forItem: barItem))
    }
    
    func testNilIsReturnedWhenTabBarItemIsNotInTabBarsItemList() {
        let sut = UITabBar()
        sut.items = [UITabBarItem(tabBarSystemItem: .history, tag: 10)]
        let barItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 12)
        
        XCTAssertNil(sut.view(forItem: barItem))
    }
    
    func testViewIsFoundForBarItem() {
        let sut = UITabBar()
        let barItem = UITabBarItem(tabBarSystemItem: .featured, tag: 99)
        sut.items = [barItem]
        
        let view = sut.view(forItem: barItem)
        XCTAssertNotNil(view)
    }
    
    func testCorrectViewIsReturnedForBarItem() {
        let sut = UITabBar()
        let barItem = UITabBarItem(tabBarSystemItem: .featured, tag: 99)
        let otherBarItem1 = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        let otherBarItem2 = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        sut.items = [otherBarItem1, barItem, otherBarItem2]
        
        let view = sut.view(forItem: barItem)
        XCTAssertNotNil(view)
        
        let orderedControls: [UIView] = sut.subviews.flatMap { $0 as? UIControl }.sorted { lhs, rhs in lhs.frame.minX < rhs.frame.minX }
        let indexOfViewInControl = orderedControls.index(of: view!)
        XCTAssertNotNil(indexOfViewInControl)
        XCTAssertEqual(indexOfViewInControl, 1)
    }
    
    func testNilIsReturnedIfThereAreUnexpectedSubviewsInTabBar() {
        let sut = UITabBar()
        let barItem = UITabBarItem(tabBarSystemItem: .featured, tag: 99)
        sut.items = [barItem]
        
        //add a few UIControl subviews to mess up index
        for _ in 0..<10 {
            sut.addSubview(UIControl(frame: .zero))
        }
        
        let view = sut.view(forItem: barItem)
        XCTAssertNil(view)
    }
    
}
