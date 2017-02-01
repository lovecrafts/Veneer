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
    
    required public init(inverseMaskView: UIView? = nil, maskInsets: UIEdgeInsets = .zero) {
        super.init(frame: .zero)
        
        self.inverseMaskView = inverseMaskView
        self.maskInsets = maskInsets
        
        self.layer.mask = maskLayer
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        maskLayer.path = maskPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
    }
    
    private var maskPath: CGPath {
        let path = CGMutablePath()
        
        path.addRect(self.bounds)
        
        if let inverseMaskView = inverseMaskView {
            let convertedFrame = self.convert(inverseMaskView.frame, from: inverseMaskView.superview)
            path.addRect(convertedFrame.applying(insets: maskInsets))
        }
        
        return path
    }
}
