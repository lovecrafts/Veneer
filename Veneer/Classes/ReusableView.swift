//
//  ReusableView.swift
//  Pods
//
//  Created by Sam Watts on 13/03/2017.
//
//

import Foundation

public protocol ReusableContainerView {
    
    func reusableView(atIndexPath indexPath: IndexPath) -> UIView? //instance of cell to be tracked
}

//MARK: Default implementations

extension UITableView: ReusableContainerView {
    
    public func reusableView(atIndexPath indexPath: IndexPath) -> UIView? {
        return self.cellForRow(at: indexPath)
    }
}

extension UICollectionView: ReusableContainerView {
    
    public func reusableView(atIndexPath indexPath: IndexPath) -> UIView? {
        return self.cellForItem(at: indexPath)
    }
}
