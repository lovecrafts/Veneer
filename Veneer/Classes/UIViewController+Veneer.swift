//
//  UIViewController+Veneer.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

public extension UIViewController {
    
    public func showVeneer() {
        guard self.veneerWindow == nil else {
            print("Error: unable to show veneer when one has already been shown")
            return
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.windowLevel = UIWindowLevelStatusBar + 1
        
        window.rootViewController = VeneerRootViewController()
        
        window.makeKeyAndVisible()
        
        //store window to prevent it being removed on deinit
        self.veneerWindow = window
    }
}
