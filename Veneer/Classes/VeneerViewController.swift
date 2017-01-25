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
    
    @available(*, unavailable, message: "init(coder:) is unavailable, use init(highlights:) instead")
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    @available(*, unavailable, message: "init(nibName:bundle:) is unavailable, use init(highlights:) instead")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError() }
    
    deinit {
        
        //remove observer for all highlights
        highlightAndViewPairs.flatMap { $0.highlight.view }.forEach { view in
            view.layer.removeObserver(self, forKeyPath: "bounds")
        }
    }
    
    let highlightAndViewPairs: [(highlight: Highlight, view: HighlightView)]
    
    required init(highlights: [Highlight]) {
        let highlightViews = highlights.map { _ in HighlightView() } //1 highlight view per highlight
        highlightAndViewPairs = zip(highlights, highlightViews).map { ($0, $1) }
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add views for highlights
        highlightAndViewPairs.map { $0.view }.forEach(self.view.addSubview)
        
        //observe position
        highlightAndViewPairs.map { $0.highlight }.forEach(observeHighlightPosition)
        
        //set initial position
        highlightAndViewPairs.forEach(self.syncHighlight)
        
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
        
        guard let indexOfMatchingPair = highlightAndViewPairs.index(where: { return $0.highlight.view?.layer == observedLayer }) else { return }
        
        let matchingPair = highlightAndViewPairs[indexOfMatchingPair]
        
        syncHighlight(matchingPair.highlight, withView: matchingPair.view)
    }
    
    func syncHighlight(_ highlight: Highlight, withView highlightView: HighlightView) {
        switch highlight {
        case .view(let view):
            let convertedFrame = self.view.convert(view.frame, from: view.superview)
            highlightView.frame = convertedFrame
        case .barButtonItem(let barButtonItem):
            let convertedFrame = barButtonItem.customView?.frame ?? .zero
            highlightView.frame = convertedFrame
        }
    }
}
