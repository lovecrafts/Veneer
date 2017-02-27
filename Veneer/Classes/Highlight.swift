//
//  Highlight.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

public struct Highlight {
    
    public enum ViewType {
        
        case view(view: UIView)
        case viewUnion(views: [UIView])
        case barButtonItem(barButtonItem: UIBarButtonItem)
        case tabBarItem(tabBar: UITabBar, tabBarItem: UITabBarItem)
    }
    
    let viewType: ViewType
    let borderInsets: UIEdgeInsets
    
    let lineDashColor: UIColor
    let lineDashWidth: CGFloat
    let lineDashPattern: [Int]
    let cornerRadius: CGFloat
    
    public init(
        viewType: ViewType,
        borderInsets: UIEdgeInsets = .zero,
        lineDashColor: UIColor = .black,
        lineDashPattern: [Int] = [5, 5],
        lineDashWidth: CGFloat = 5,
        cornerRadius: CGFloat = 5
        ) {
        
        self.viewType = viewType
        self.borderInsets = borderInsets
        self.lineDashColor = lineDashColor
        self.lineDashPattern = lineDashPattern
        self.lineDashWidth = lineDashWidth
        self.cornerRadius = cornerRadius
    }
}

public extension Highlight {
    
    var views: [UIView] {
        switch self.viewType {
        case .view(let view):
            return [view]
        case .viewUnion(let views):
            return views
        case .barButtonItem(let barButtonItem):
            return [barButtonItem.customView].flatMap { $0 }
        case .tabBarItem(let tabBar, let tabBarItem):
            return [tabBar.view(forItem: tabBarItem)].flatMap { $0 }
        }
    }
}
