//
//  VeneerDimmingView.swift
//  Pods
//
//  Created by Sam Watts on 30/01/2017.
//
//

import UIKit

public class VeneerDimmingView: UIView {
    
    @available(*, unavailable, message: "init(frame:) is unavailable, use init() instead")
    override init(frame: CGRect) { fatalError() }
    
    @available(*, unavailable, message: "init?(coder:) is unavailable, use init() instead")
    public required init?(coder aDecoder: NSCoder) { fatalError() }
    
    private let maskLayer: CAShapeLayer = {
        let mask = CAShapeLayer()
        mask.fillRule = kCAFillRuleEvenOdd
        return mask
    }()
    
    var inverseMaskView: UIView? {
        didSet {
            self.setNeedsLayout()
        }
    }
    var maskInsets: UIEdgeInsets = .zero {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    required public init(inverseMaskView: UIView?, maskInsets: UIEdgeInsets = .zero) {
        super.init(frame: .zero)
        
        self.inverseMaskView = inverseMaskView
        self.maskInsets = maskInsets
        
        self.layer.mask = maskLayer
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        maskLayer.path = maskPath
    }
    
    private var maskPath: CGPath {
        let path = CGMutablePath()
        
        path.addRect(self.bounds)
        
        if let inverseMaskView = inverseMaskView {
            path.addRect(inverseMaskView.frame.applying(insets: maskInsets))
        }
        
        return path
    }
}
