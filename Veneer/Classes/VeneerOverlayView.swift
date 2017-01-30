//
//  VeneerOverlayView.swift
//  Pods
//
//  Created by Sam Watts on 30/01/2017.
//
//

import UIKit

open class VeneerOverlayView: UIView {
    
    @available(*, unavailable, message: "init?(coder:) is unavailable, use init() instead")
    public required init?(coder aDecoder: NSCoder) { fatalError() }
    
    @available(*, unavailable, message: "init(frame:) is unavailable, use init() instead")
    override init(frame: CGRect) { fatalError() }

    public required init() {
        super.init(frame: .zero)
    }
    
    var highlightViewFrame: CGRect?
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if let highlightViewFrame = highlightViewFrame {
            layoutSubviews(withHighlightViewFrame: highlightViewFrame)
        }
    }
    
    open func layoutSubviews(withHighlightViewFrame highlightFrame: CGRect) {
        //function to be implemented by subclasses
    }

}
