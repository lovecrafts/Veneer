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
        case barButtonItem(barButtonItem: UIBarButtonItem)
    }
    
    let viewType: ViewType
    let borderInsets: UIEdgeInsets
    
    let lineDashColor: UIColor?
    let lineDashWidth: CGFloat?
    let lineDashPattern: [Int]?
    
    public init(viewType: ViewType, borderInsets: UIEdgeInsets = .zero, lineDashColor: UIColor? = nil, lineDashPattern: [Int]? = nil, lineDashWidth: CGFloat? = nil) {
        self.viewType = viewType
        self.borderInsets = borderInsets
        self.lineDashColor = lineDashColor
        self.lineDashPattern = lineDashPattern
        self.lineDashWidth = lineDashWidth
    }
}

public extension Highlight {
    
    var view: UIView? {
        switch self.viewType {
        case .view(let view):
            return view
        case .barButtonItem(let barButtonItem):
            return barButtonItem.customView
        }
    }
}
