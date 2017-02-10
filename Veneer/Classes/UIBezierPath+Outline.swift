//
//  UIBezierPath+Outline.swift
//  Pods
//
//  Created by Sam Watts on 10/02/2017.
//
//

import UIKit

extension UIBezierPath {
    
    //code adapted from http://stackoverflow.com/a/35711310/1138900
    //works through top points from left to right, then bottom points right to left, adding intersection points if crossing the axis of previous point
    
    convenience init(outliningViewFrames frames: [CGRect]) {

        self.init()
        
        //nothing to do for empty frames
        guard frames.isEmpty == false else { return }
        
        //check for simple case of a single frame
        guard frames.count != 1 else { self.append(UIBezierPath(rect: frames[0])); return }
        
        // top left and right corners of each view
        // sorted from left to right, top to bottom
        var topPoints:[CGPoint] = frames.reduce([]) { $0 + [CGPoint(x: $1.minX, y: $1.minY), CGPoint(x: $1.maxX, y: $1.minY)] }
        topPoints = topPoints.sorted(by: { $0.x == $1.x ? $0.y < $1.y : $0.x < $1.x })
        
        // trace top line from left to right
        // moving up or down when appropriate
        var previousPoint = topPoints.removeFirst()
        self.move(to: previousPoint)
        for point in topPoints {
            
            //guard against non outline points (e.g. corner points withing other rects)
            guard point.y == previousPoint.y
                || point.y < previousPoint.y
                && frames.contains(where: {$0.minX == point.x && $0.minY < previousPoint.y })
                || point.y > previousPoint.y
                && !frames.contains(where: { $0.maxX > point.x && $0.minY < point.y })
                else  { continue }
            
            if point.y < previousPoint.y {
                self.addLine(to: CGPoint(x:point.x, y:previousPoint.y))
            } else if point.y > previousPoint.y {
                self.addLine(to: CGPoint(x:previousPoint.x, y:point.y))
            }
            
            self.addLine(to: point)
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
            
            //guard against non outline points (e.g. corner points withing other rects)
            guard point.y == previousPoint.y
                || point.y > previousPoint.y
                && frames.contains(where: {$0.maxX == point.x && $0.maxY > previousPoint.y })
                || point.y < previousPoint.y
                && !frames.contains(where: { $0.minX < point.x && $0.maxY > point.y })
                else  { continue }
            
            if point.y > previousPoint.y {
                self.addLine(to: CGPoint(x:point.x, y:previousPoint.y))
            } else if point.y < previousPoint.y {
                self.addLine(to: CGPoint(x:previousPoint.x, y:point.y))
            }
            
            self.addLine(to: point)
            previousPoint = point
        }
        
        // close back to leftmost point of top line
        self.close()
    }
}