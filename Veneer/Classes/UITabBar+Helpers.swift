//
//  UITabBar+Helpers.swift
//  Pods
//
//  Created by Sam Watts on 02/02/2017.
//
//

import UIKit

extension UITabBar {
    
    func view(forItem item: UITabBarItem) -> UIView? {
        let tabBarItems = self.items ?? []
        
        //get a list of potential subviews (sorted horizontally so we can use the tab bar item order)
        let potentialSubviews = self.subviews
            .flatMap { $0 as? UIControl }
            .sorted { lhs, rhs in lhs.frame.minX < rhs.frame.minX }
        
        //look for a valid index using tab bar item
        guard let itemIndex = tabBarItems.index(of: item) else { return nil }
        guard itemIndex >= 0, itemIndex < potentialSubviews.count else { return nil }
        
        //fetch from list of subviews
        let matchingSubview = potentialSubviews[itemIndex]
        return matchingSubview
    }
}