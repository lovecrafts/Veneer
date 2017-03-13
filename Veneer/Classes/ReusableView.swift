//
//  ReusableView.swift
//  Pods
//
//  Created by Sam Watts on 13/03/2017.
//
//

import Foundation

public enum ReuseType {
    case cell
    case supplementary
}

public protocol ReusableContainerView {
    
    var containerView: UIView { get }  //return instance of backing view, e.g. collection or table view
    func reusableView(atIndexPath indexPath: IndexPath, ofType type: ReuseType) -> UIView? //instance of cell to be tracked
}
