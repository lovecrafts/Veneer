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
    
    var inverseMaskViews: [UIView] = [] {
        didSet {
            self.setNeedsLayout()
        }
    }
    var maskInsets: UIEdgeInsets = .zero {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    required public init(inverseMaskViews: [UIView], maskInsets: UIEdgeInsets = .zero) {
        super.init(frame: .zero)
        
        self.inverseMaskViews = inverseMaskViews
        self.maskInsets = maskInsets
        
        self.layer.mask = maskLayer
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        maskLayer.path = maskPath
    }
    
    private var maskPath: CGPath {
        let path = UIBezierPath()
        
        path.append(UIBezierPath(rect: self.bounds))
        
        //calculate enclosing path for inverse mask views
        if inverseMaskViews.isEmpty == false {
            let frames = inverseMaskViews.map { $0.frame }
            let inverseMaskPath = HighlightView.enclosingPathForViews(viewFrames: frames)
            path.append(inverseMaskPath)
        }
        
        return path.cgPath
    }
}
