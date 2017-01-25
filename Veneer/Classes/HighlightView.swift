//
//  HighlightView.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

public class HighlightView: UIView {
    
    @available(*, unavailable, message: "init(frame:) is unavailable, use init(highlight:) instead")
    override init(frame: CGRect) { fatalError() }
    
    @available(*, unavailable, message: "init?(coder:) is unavailable, use init(highlight:) instead")
    required public init?(coder aDecoder: NSCoder) { fatalError() }
    
    public dynamic var lineDashColor: UIColor = .black {
        didSet {
            borderLayer.strokeColor = lineDashColor.cgColor
        }
    }
    
    public dynamic var lineDashPattern: [Int] = [10, 10] {
        didSet {
            borderLayer.lineDashPattern = lineDashPattern as [NSNumber]
        }
    }
    
    public dynamic var lineDashWidth: CGFloat = 10 {
        didSet {
            borderLayer.lineWidth = lineDashWidth
        }
    }
    
    lazy private(set) var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.layer.addSublayer(borderLayer)
        
        borderLayer.strokeColor = lineDashColor.cgColor
        borderLayer.lineDashPattern = lineDashPattern as [NSNumber]
        borderLayer.lineWidth = lineDashWidth
    }
    
    override public func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        guard layer == self.layer else { return }
        
        let halfLineWidth = borderLayer.lineWidth / 2
        let lineBounds = layer.bounds
            .insetBy(dx: halfLineWidth, dy: halfLineWidth)
            .offsetBy(dx: -halfLineWidth / 2, dy: -halfLineWidth / 2)
                
        borderLayer.frame = lineBounds
        
        let path = UIBezierPath(rect: lineBounds)
        borderLayer.path = path.cgPath
    }
}
