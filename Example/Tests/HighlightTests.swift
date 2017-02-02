//
//  HighlightTests.swift
//  Veneer
//
//  Created by Sam Watts on 02/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Veneer

class HighlightTests: XCTestCase {
    
    func testDefaultValues() {
        let sut = Highlight(viewType: .view(view: UIView()))
        
        XCTAssertEqual(sut.borderInsets, .zero)
        XCTAssertEqual(sut.lineDashColor, .black)
        XCTAssertEqual(sut.lineDashPattern, [5, 5])
        XCTAssertEqual(sut.lineDashWidth, 5)
    }
    
    func testFetchingViewForViewReturnsTheView() {
        let view = UIView()
        let sut = Highlight(viewType: .view(view: view))
        
        XCTAssertNotNil(sut.view)
        XCTAssertEqual(sut.view, view)
    }
    
    func testFetchingViewForBarButtonItemReturnsCustomView() {
        let customView = UIView()
        let barButtonItem = UIBarButtonItem(customView: customView)
        let sut = Highlight(viewType: .barButtonItem(barButtonItem: barButtonItem))
        
        XCTAssertNotNil(sut.view)
        XCTAssertEqual(sut.view, customView)
    }
    
    func testFetchingViewForBarButtonItemReturnsNilWhenThereIsNoCustomView() {
        let barButtonItem = UIBarButtonItem(title: "title", style: .plain, target: nil, action: nil)
        let sut = Highlight(viewType: .barButtonItem(barButtonItem: barButtonItem))
        
        XCTAssertNil(sut.view)
    }
    
    func testFetchingViewForTabBarItem() {
        let tabBar = UITabBar(frame: .zero)
        let barItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 12)
        tabBar.items = [barItem]
        
        let sut = Highlight(viewType: .tabBarItem(tabBar: tabBar, tabBarItem: barItem))
        
        XCTAssertNotNil(sut.view)
    }
    
}
