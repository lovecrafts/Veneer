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

class VeneerRootViewController<T: VeneerOverlayView>: VeneerViewController {
    

    override class func initialize() {

        //if we are being loaded after the application appearance values have been set, skip this step
        if VeneerDimmingView.appearance().backgroundColor == nil {
            //set default appearance values, can be overriden (see example app delegate)
            VeneerDimmingView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
    }
    
    @available(*, unavailable, message: "init(coder:) is unavailable, use init(highlight:) instead")
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    @available(*, unavailable, message: "init(nibName:bundle:) is unavailable, use init(highlight:) instead")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError() }
    
    deinit {
        
        //remove observer for highlight view
        highlight.views.forEach { view in
            view.layer.removeObserver(self, forKeyPath: "bounds")
        }
    }
    
    let highlight: Highlight
    let highlightView: HighlightView
    let overlayView: T
    let dimmingView: VeneerDimmingView
    
    required init(highlight: Highlight, overlayView: T) {
        self.highlightView = HighlightView(highlight: highlight)
        self.highlight = highlight
        self.overlayView = overlayView
        self.dimmingView = VeneerDimmingView(inverseMaskView: highlightView)
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(dimmingView)
        
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
        highlight.views.forEach { view in
            view.layer.addObserver(self, forKeyPath: "bounds", options: [], context: nil)
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let observedLayer = object as? CALayer else { return }
        updateHighlightViewFrame()
    }
    
    func updateHighlightViewFrame(completion: @escaping () -> () = { _ in }) {
        
        //pushing onto next event loop since components like bar button item don't have their frames updated immediately
        DispatchQueue.main.async {
            let viewsToHighlight = self.highlight.views
            
            let convertedFrames = viewsToHighlight
                .map { self.view.convert($0.frame, from: $0.superview) }
                .map { $0.applying(insets: self.highlight.borderInsets) }
            
            let combinedFrame: CGRect = convertedFrames.reduce(.null) { combined, frame in return combined.union(frame) }
            self.highlightView.frame = combinedFrame
            
            //update inverse mask in dimming view
            self.dimmingView.setNeedsLayout()
            
            completion()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //update on layout
        updateHighlightViewFrame {
            //update highlight view position for overlay view
            self.overlayView.highlightViewFrame = self.highlightView.frame
        }
        
        //update overlay view to match bounds
        overlayView.frame = self.view.bounds
        
        //dim entire view
        dimmingView.frame = self.view.bounds
    }
}
