//
//  Highlight.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import Foundation

public enum Highlight {
    
    case view(view: UIView)
}

extension Highlight {
    
    var view: UIView? {
        switch self {
        case .view(let view):
            return view
        }
    }
}
