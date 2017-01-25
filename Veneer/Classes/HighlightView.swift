//
//  HighlightView.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

class HighlightView: UIView {
    
    @available(*, unavailable, message: "init(frame:) is unavailable, use init(highlight:) instead")
    override init(frame: CGRect) { fatalError() }
    
    @available(*, unavailable, message: "init?(coder:) is unavailable, use init(highlight:) instead")
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    dynamic var lineDashColor: UIColor = .black
    dynamic var lineDashPattern: [Int] = [10, 10]
    dynamic var lineDashWidth: CGFloat = 10
    
    lazy private(set) var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    init(highlight: Highlight) {
        super.init(frame: .zero)
        
        self.layer.addSublayer(borderLayer)
        
        borderLayer.strokeColor = lineDashColor.cgColor
        borderLayer.lineDashPattern = lineDashPattern as [NSNumber]
        borderLayer.lineWidth = lineDashWidth
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        guard layer == self.layer else { return }
        
        borderLayer.frame = layer.bounds
        
        let path = UIBezierPath(rect: layer.bounds)
        borderLayer.path = path.cgPath
    }
}
