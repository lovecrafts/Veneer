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
    
    lazy private(set) var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    private let highlight: Highlight
    
    init(highlight: Highlight) {
        self.highlight = highlight
        
        super.init(frame: .zero)
        
        self.layer.addSublayer(borderLayer)
        
        borderLayer.strokeColor = highlight.lineDashColor.cgColor
        borderLayer.lineDashPattern = highlight.lineDashPattern as [NSNumber]
        borderLayer.lineWidth = highlight.lineDashWidth
    }
    
    override public func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        guard layer == self.layer else { return }
        guard layer.bounds != .zero else { return } //nothing to layout yet
        
        let halfLineWidth = borderLayer.lineWidth / 2
        let lineBounds = layer.bounds
            .insetBy(dx: halfLineWidth, dy: halfLineWidth)
            .offsetBy(dx: -halfLineWidth / 2, dy: -halfLineWidth / 2)
                
        borderLayer.frame = lineBounds
        
        switch highlight.viewType {
        case .viewUnion(let views):
            borderLayer.path = UIBezierPath(outliningViewFrames: views.map { self.convert($0.frame, from: $0.superview) }).cgPath
        default:
            borderLayer.path = UIBezierPath(roundedRect: lineBounds, cornerRadius: highlight.cornerRadius).cgPath
        }
    }
}
