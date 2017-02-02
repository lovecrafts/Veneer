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
        guard insets.left + insets.right <= self.width, insets.top + insets.bottom <= self.height else { return self }
        
        return self
            .insetBy(dx: (insets.left + insets.right) / 2, dy: (insets.top + insets.bottom) / 2)
            .offsetBy(dx: (insets.left - insets.right) / 2, dy: (insets.top - insets.bottom) / 2)
    }
}
