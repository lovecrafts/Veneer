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
    
    func testFetchingViewForViewReturnsJustTheView() {
        let view = UIView()
        let sut = Highlight(viewType: .view(view: view))
        
        XCTAssertEqual(sut.views.count, 1)
        XCTAssertEqual(sut.views.first, view)
    }
    
    func testFetchingViewsForUnionReturnsAllViews() {
        let views = [UIView(), UIView()]
        let sut = Highlight(viewType: .viewUnion(views: views))
        
        XCTAssertEqual(sut.views.count, 2)
        XCTAssertEqual(sut.views, views)
    }
    
    func testFetchingViewForBarButtonItemReturnsCustomView() {
        let customView = UIView()
        let barButtonItem = UIBarButtonItem(customView: customView)
        let sut = Highlight(viewType: .barButtonItem(barButtonItem: barButtonItem))
        
        XCTAssertEqual(sut.views.count, 1)
        XCTAssertEqual(sut.views.first, customView)
    }
    
    func testFetchingViewForBarButtonItemReturnsEmptyWhenThereIsNoCustomView() {
        let barButtonItem = UIBarButtonItem(title: "title", style: .plain, target: nil, action: nil)
        let sut = Highlight(viewType: .barButtonItem(barButtonItem: barButtonItem))
        
        XCTAssertTrue(sut.views.isEmpty)
    }
    
    func testFetchingViewForTabBarItem() {
        let tabBar = UITabBar(frame: .zero)
        let barItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 12)
        tabBar.items = [barItem]
        
        let sut = Highlight(viewType: .tabBarItem(tabBar: tabBar, tabBarItem: barItem))
        
        XCTAssertEqual(sut.views.count, 1)
    }
    
}
