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
    
    public init(viewType: ViewType, borderInsets: UIEdgeInsets = .zero) {
        self.viewType = viewType
        self.borderInsets = borderInsets
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
