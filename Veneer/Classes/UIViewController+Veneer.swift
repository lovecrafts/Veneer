//
//  UIViewController+Veneer.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

public enum DismissType {
    case programmatic
    case tapToDismiss
    case tapOnHighlight
}

extension DismissType: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .programmatic: return "Dismissed programmatically"
        case .tapToDismiss: return "Tapped on background / close button"
        case .tapOnHighlight: return "Tapped on highlighted view(s)"
        }
    }
}

public extension UIViewController {
    
    public func showVeneer(withHighlight highlight: Highlight, overlayViewType: VeneerOverlayView.Type = VeneerOverlayView.self) {
        guard UIApplication.shared.veneerWindow == nil else {
            print("Error: unable to show veneer when one has already been shown")
            return
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.windowLevel = UIWindowLevelStatusBar + 1
        
        window.rootViewController = VeneerRootViewController(highlight: highlight, overlayView: overlayViewType.init())
        
        window.rootViewController?.view.alpha = 0
        
        window.makeKeyAndVisible()
        
        //fade in window on initial display
        UIView.animate(withDuration: 0.2) {
            window.rootViewController?.view.alpha = 1
        }
        
        //store window to prevent it being removed on deinit
        UIApplication.shared.veneerWindow = window
    }
    
    public func dismissVeneer(animated: Bool = true, completion: ((DismissType) -> ())? = nil) {
        guard let window = UIApplication.shared.veneerWindow else {
            print("Warning: attempting to dismiss non visible veneer")
            return
        }
        
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            window.alpha = 0.0
        }) { _ in
            //release veneer window to resign as key
            UIApplication.shared.veneerWindow = nil

            completion?(.programmatic)
        }
    }
}
