//
//  UIKit+Helpers.swift
//  Veneer
//
//  Created by Sam Watts on 24/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var random: UIColor {
        
        let hue = ( Double(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) ) / 256.0 )
        let saturation = ( (Double(arc4random()).truncatingRemainder(dividingBy: 128)) / 256.0 ) + 0.5
        let brightness = ( (Double(arc4random()).truncatingRemainder(dividingBy: 128)) / 256.0 ) + 0.5
        
        return UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: 1.0)
    }
}

extension UIView {
    
    func mark(withColor color: UIColor = .random, borderWidth: CGFloat = 2) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
    }
}

extension UIBarButtonItem {
    
    convenience init(customViewWithTitle title: String, target: AnyObject?, action: Selector) {
        let customView = UIButton(type: .custom)
        customView.setTitle(title, for: .normal)
        customView.setTitleColor(.black, for: .normal)
        customView.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.buttonFontSize - 2)
        customView.sizeToFit()
        
        customView.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: customView)
    }
}
