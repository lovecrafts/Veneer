//
//  UITabBar+Helpers.swift
//  Pods
//
//  Created by Sam Watts on 02/02/2017.
//
//

import UIKit

extension UITabBar {
    
    //helper function to get a representative view when showing highlight over tab bar item
    //note this currently returns a much wider view than expected, but getting the actual view
    //might require some extra subview "examination"
    func view(forItem item: UITabBarItem) -> UIView? {
        let tabBarItems = self.items ?? []
        
        //get a list of potential subviews (sorted horizontally so we can use the tab bar item order)
        let potentialSubviews = self.subviews
            .flatMap { $0 as? UIControl } //check for control to ignore background, visual effect etc
            .sorted { lhs, rhs in lhs.frame.minX < rhs.frame.minX }
        
        //look for a valid index using tab bar item
        guard let itemIndex = tabBarItems.index(of: item) else { return nil }
        guard itemIndex >= 0, itemIndex < potentialSubviews.count else { return nil }
        
        //fetch from list of subviews
        let matchingSubview = potentialSubviews[itemIndex]
        return matchingSubview
    }
}
