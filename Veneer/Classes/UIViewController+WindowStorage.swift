//
//  UIViewController+WindowStorage.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit
import ObjectiveC.runtime

private var veneerWindowAssociatedObjectKey: UInt8 = 42

extension UIViewController {
    
    var veneerWindow: UIWindow? {
        get {
            return objc_getAssociatedObject(self, &veneerWindowAssociatedObjectKey) as? UIWindow
        }
        set {
            objc_setAssociatedObject(self, &veneerWindowAssociatedObjectKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
