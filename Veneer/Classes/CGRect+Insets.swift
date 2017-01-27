//
//  CGRect+Insets.swift
//  Pods
//
//  Created by Sam Watts on 27/01/2017.
//
//

import UIKit

extension CGRect {
    
    func applying(insets: UIEdgeInsets) -> CGRect {
        return self
            .insetBy(dx: (insets.left + insets.right) / 2, dy: (insets.top + insets.bottom) / 2)
            .offsetBy(dx: (insets.left - insets.right) / 2, dy: (insets.top - insets.bottom) / 2)
    }
}
