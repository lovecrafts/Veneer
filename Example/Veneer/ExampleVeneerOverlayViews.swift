//
//  ExampleVeneerOverlayViews.swift
//  Veneer
//
//  Created by Sam Watts on 03/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Veneer

class BarButtonItemOverlayView: VeneerOverlayView {
    
    let speechBubble: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        view.backgroundColor = .random
        view.mark(withColor: .red)
        return view
    }()
    
    let arrow: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        view.backgroundColor = .random
        view.mark(withColor: .blue)
        return view
    }()
    
    required init() {
        super.init()
        
        self.mark(withColor: .random)
        
        self.addSubview(speechBubble)
        self.addSubview(arrow)
    }
    
    override func layoutSubviews(withHighlightViewFrame highlightFrame: CGRect) {
        
        speechBubble.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        arrow.frame.origin = CGPoint(x: highlightFrame.midX - 25, y: highlightFrame.maxY + 20)
    }
}

class ViewOverlayView: VeneerOverlayView {
    
    let speechBubble: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        view.backgroundColor = .random
        view.mark(withColor: .red)
        return view
    }()
    
    let alpaca: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 400))
        view.backgroundColor = .random
        view.mark(withColor: .blue)
        return view
    }()
    
    required init() {
        super.init()
        
        self.mark(withColor: .random)
        
        self.addSubview(speechBubble)
        self.addSubview(alpaca)
    }
    
    override func layoutSubviews(withHighlightViewFrame highlightFrame: CGRect) {
        
        //for compact width show only speech bubble in center
        if self.traitCollection.horizontalSizeClass == .compact {
            speechBubble.isHidden = false
            alpaca.isHidden = true
            
            //calculate largest free space to show view
            let slices = self.bounds.divided(atDistance: highlightFrame.minY, from: .minYEdge)
            let top = slices.slice
            let bottom = slices.remainder.insetBy(dx: 0, dy: highlightFrame.height / 2).offsetBy(dx: 0, dy: highlightFrame.height / 2)
            
            if top.height > bottom.height {
                speechBubble.center = CGPoint(x: self.bounds.midX, y: top.midY)
            } else {
                speechBubble.center = CGPoint(x: self.bounds.midX, y: bottom.midY)
            }
            
        } else {
            speechBubble.isHidden = false
            alpaca.isHidden = false
            
            if highlightFrame.midX > self.bounds.midX {
                speechBubble.frame.origin = CGPoint(
                    x: highlightFrame.minX - speechBubble.bounds.width,
                    y: highlightFrame.midY - speechBubble.bounds.height / 2
                )
                
                alpaca.frame.origin = CGPoint(x: 50, y: self.bounds.height - alpaca.bounds.height)
                
            } else {
                speechBubble.frame.origin = CGPoint(
                    x: highlightFrame.maxX,
                    y: highlightFrame.midY - speechBubble.bounds.height / 2
                )
                
                alpaca.frame.origin = CGPoint(x: self.bounds.width - 50 - alpaca.bounds.width, y: self.bounds.height - alpaca.bounds.height)
            }
            
            if alpaca.frame.intersects(speechBubble.frame) {
                alpaca.isHidden = true
            }
            
        }
        
    }
}

class TabBarItemOverlayView: VeneerOverlayView {
    
    required init() {
        super.init()
        
        self.mark(withColor: .random)
    }
    
    override func layoutSubviews(withHighlightViewFrame highlightFrame: CGRect) {
    }
}
