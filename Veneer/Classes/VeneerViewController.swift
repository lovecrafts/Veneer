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
    let highlightViews: [HighlightView]
    let overlayView: T
    let dimmingView: VeneerDimmingView
    let completion: ((DismissType) -> ())?
    
    required init(highlight: Highlight, overlayView: T) {
        self.highlightViews = highlight.views.map { _ in HighlightView(highlight: highlight) }
        self.highlight = highlight
        self.overlayView = overlayView
        self.dimmingView = VeneerDimmingView(inverseMaskViews: highlightViews)
        self.completion = nil
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(dimmingView)
        
        //add highlight and overlay views (highlight above)
        self.view.addSubview(overlayView)
        highlightViews.forEach(self.view.addSubview)
        
        //observe position
        observeHighlightPosition(highlight: highlight)
        
        //set initial position
        updateHighlightViewFrame()
        
        let dismissTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VeneerRootViewController.dismissCurrentVeneer(recognizer:)))
        self.view.addGestureRecognizer(dismissTapGestureRecognizer)
    }
    
    func dismissCurrentVeneer(recognizer: UITapGestureRecognizer) {
        let locationInView = recognizer.location(in: self.view)
        
        let hitHiglightView: Bool
        if let hitView = self.view.hitTest(locationInView, with: nil) as? HighlightView {
            hitHiglightView = highlightViews.contains(hitView) //check if we hit one of the higlight views
        } else {
            hitHiglightView = false
        }
        
        let dismissType: DismissType = hitHiglightView ? .tapOnHighlight : .tap
        
        self.dismissVeneer(animated: true) { [weak self] _ in
            self?.completion?(dismissType)
        }
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
            
            zip(viewsToHighlight, self.highlightViews).forEach { view, highlightView in
                
                //update each highlight view with correspinging original view (including insets)
                highlightView.frame = self.view
                    .convert(view.frame, from: view.superview)
                    .applying(insets: self.highlight.borderInsets)
            }
            
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
            self.overlayView.highlightViewFrame = self.highlightViews.reduce(CGRect.null) { combined, view in combined.union(view.frame) }
        }
        
        //update overlay view to match bounds
        overlayView.frame = self.view.bounds
        
        //dim entire view
        dimmingView.frame = self.view.bounds
    }
}
