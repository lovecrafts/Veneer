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
        
        let halfLineWidth = borderLayer.lineWidth / 2
        let lineBounds = layer.bounds
            .insetBy(dx: halfLineWidth, dy: halfLineWidth)
            .offsetBy(dx: -halfLineWidth / 2, dy: -halfLineWidth / 2)
                
        borderLayer.frame = lineBounds
        
        switch highlight.viewType {
        case .viewUnion(let views):
            borderLayer.path = HighlightView.enclosingPathForViews(viewFrames: views.map { self.convert($0.frame, from: $0.superview) }).cgPath
        default:
            borderLayer.path = UIBezierPath(rect: lineBounds).cgPath
        }
    }
    
    static func enclosingPathForViews(viewFrames frames: [CGRect]) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        // top left and right corners of each view
        // sorted from left to right, top to bottom
        var topPoints:[CGPoint] = frames.reduce([]) { $0 + [CGPoint(x: $1.minX, y: $1.minY), CGPoint(x: $1.maxX, y: $1.minY)] }
        topPoints = topPoints.sorted(by: { $0.x == $1.x ? $0.y < $1.y : $0.x < $1.x })
        
        // trace top line from left to right
        // moving up or down when appropriate
        guard var previousPoint = topPoints.first else { return path }
        path.move(to: previousPoint)
        for point in topPoints {
            
            guard point.y == previousPoint.y
                || point.y < previousPoint.y
                && frames.contains(where: {$0.minX == point.x && $0.minY < previousPoint.y })
                || point.y > previousPoint.y
                && !frames.contains(where: { $0.maxX > point.x && $0.minY < point.y })
                else  { continue }
            
            if point.y < previousPoint.y {
                path.addLine(to: CGPoint(x:point.x, y:previousPoint.y))
            } else if point.y > previousPoint.y {
                path.addLine(to: CGPoint(x:previousPoint.x, y:point.y))
            }
            
            path.addLine(to: point)
            previousPoint = point
        }
        
        // botom left and right corners of each view
        // sorted from right to left, bottom to top
        var bottomPoints: [CGPoint] = frames.reduce([]) { $0 + [CGPoint(x: $1.minX, y: $1.maxY), CGPoint(x: $1.maxX, y: $1.maxY)] }
        bottomPoints = bottomPoints.sorted(by: { $0.x == $1.x ? $0.y > $1.y : $0.x > $1.x })
        
        // trace bottom line from right to left
        // starting where top line left off (rightmost top corner)
        // moving up or down when appropriate
        for point in bottomPoints {
            
            guard point.y == previousPoint.y
                || point.y > previousPoint.y
                && frames.contains(where: {$0.maxX == point.x && $0.maxY > previousPoint.y })
                || point.y < previousPoint.y
                && !frames.contains(where: { $0.minX < point.x && $0.maxY > point.y })
                else  { continue }
            
            if point.y > previousPoint.y {
                path.addLine(to: CGPoint(x:point.x, y:previousPoint.y))
            } else if point.y < previousPoint.y {
                path.addLine(to: CGPoint(x:previousPoint.x, y:point.y))
            }
            
            path.addLine(to: point)
            previousPoint = point
        }
        
        // close back to leftmost point of top line
        path.close()
        
        return path
    }
}
