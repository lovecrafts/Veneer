//
//  UIViewController+Veneer.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

public extension UIViewController {
    
    public func showVeneer(withHighlight highlight: Highlight, overlayViewType: VeneerOverlayView.Type = VeneerOverlayView.self) {
        guard UIApplication.shared.veneerWindow == nil else {
            print("Error: unable to show veneer when one has already been shown")
            return
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.windowLevel = UIWindowLevelStatusBar + 1
        
        window.rootViewController = VeneerRootViewController(highlight: highlight, overlayView: overlayViewType.init())
        
        window.makeKeyAndVisible()
        
        //store window to prevent it being removed on deinit
        UIApplication.shared.veneerWindow = window
    }
    
    public func dismissVeneer(animated: Bool = true, completion: (() -> ())? = nil) {
        guard let window = UIApplication.shared.veneerWindow else {
            print("Warning: attempting to dismiss non visible veneer")
            return
        }
        
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            window.alpha = 0.0
        }) { _ in
            //release veneer window to resign as key
            UIApplication.shared.veneerWindow = nil

            completion?()
        }
    }
}
