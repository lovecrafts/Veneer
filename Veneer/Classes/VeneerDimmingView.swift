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
        mask.fillRule = CAShapeLayerFillRule.evenOdd
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
    
    var maskCornerRadius: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    required public init(inverseMaskViews: [UIView], maskInsets: UIEdgeInsets = .zero, maskCornerRadius: CGFloat = 0) {
        super.init(frame: .zero)
        if maskCornerRadius != 0 && inverseMaskViews.count > 1 {
            preconditionFailure("Corner radius is not supported on view union masking")
        }
        
        //check if we have an appearance value configured before setting default background
        if let appearanceBackgroundColor = VeneerDimmingView.appearance().backgroundColor {
            self.backgroundColor = appearanceBackgroundColor
        } else {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
        
        self.inverseMaskViews = inverseMaskViews
        self.maskInsets = maskInsets
        self.maskCornerRadius = maskCornerRadius
        
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
            
            let inverseMaskPath: UIBezierPath
            if frames.count > 1 {
                inverseMaskPath = UIBezierPath(outliningViewFrames: frames)
            } else {
                inverseMaskPath = UIBezierPath(roundedRect: frames.first ?? .zero, cornerRadius: maskCornerRadius)
            }

            path.append(inverseMaskPath)
        }
        
        return path.cgPath
    }
}
