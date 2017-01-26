//
//  VeneerViewController.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

//public view controller use to provide a UIAppearanceContainer for customisation while keeping main root view controller internal
public class VeneerViewController: UIViewController { }

class VeneerRootViewController: VeneerViewController {
    
    override static func initialize() {
        //set default appearance values, can be overriden (see example app delegate)
        UIView.appearance(whenContainedInInstancesOf: [VeneerViewController.self]).backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    @available(*, unavailable, message: "init(coder:) is unavailable, use init(highlight:) instead")
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    @available(*, unavailable, message: "init(nibName:bundle:) is unavailable, use init(highlight:) instead")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError() }
    
    deinit {
        
        //remove observer for highlight view
        highlight.view?.layer.removeObserver(self, forKeyPath: "bounds")
    }
    
    let highlight: Highlight
    let highlightView: HighlightView
    let overlayView: UIView
    
    required init(highlight: Highlight) {
        self.highlightView = HighlightView()
        self.highlight = highlight
        self.overlayView = UIView()
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add highlight and overlay views (highlight above)
        self.view.addSubview(overlayView)
        self.view.addSubview(highlightView)
        
        //observe position
        observeHighlightPosition(highlight: highlight)
        
        //set initial position
        updateHighlightViewFrame()
        
        let dismissTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VeneerRootViewController.dismissCurrentVeneer))
        self.view.addGestureRecognizer(dismissTapGestureRecognizer)
    }
    
    func dismissCurrentVeneer() {
        self.dismissVeneer()
    }
    
    func observeHighlightPosition(highlight: Highlight) {
        highlight.view?.layer.addObserver(self, forKeyPath: "bounds", options: [], context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let observedLayer = object as? CALayer else { return }
        updateHighlightViewFrame()
    }
    
    func updateHighlightViewFrame() {
        guard let viewToHighlight = highlight.view else { return }
        
        let convertedFrame = self.view.convert(viewToHighlight.frame, from: viewToHighlight.superview)
        highlightView.frame = convertedFrame
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //update on layout
        updateHighlightViewFrame()
        
        //update overlay view based on highlight position
        overlayView.layer.borderColor = UIColor.orange.cgColor
        overlayView.layer.borderWidth = 2
        
        switch self.traitCollection.horizontalSizeClass {
        case .compact:
            overlayView.frame = self.view.bounds
        case .regular:
            //check if highlight view is to left or right of screen
            if highlightView.frame.midX > self.view.bounds.midX {
                overlayView.frame = CGRect(x: 0, y: 0, width: highlightView.frame.minX, height: self.view.bounds.height)
            } else {
                overlayView.frame = CGRect(x: highlightView.frame.maxX, y: 0, width: self.view.bounds.width - highlightView.frame.maxX, height: self.view.bounds.height)
            }
        case.unspecified:
            overlayView.frame = .zero
        }
        
    }
}
