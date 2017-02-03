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
            
            speechBubble.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            
        } else {
            speechBubble.isHidden = false
            alpaca.isHidden = false
            
            speechBubble.frame.origin = CGPoint(
                x: self.bounds.width - speechBubble.bounds.width,
                y: highlightFrame.midY - speechBubble.bounds.height / 2
            )
            
            alpaca.frame.origin = CGPoint(x: 100, y: self.bounds.height - alpaca.bounds.height)
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
