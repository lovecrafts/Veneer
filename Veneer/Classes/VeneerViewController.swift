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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VeneerRootViewController.dismissCurrentVeneer))
        self.view.addGestureRecognizer(dismissTapGestureRecognizer)
    }
    
    func dismissCurrentVeneer() {
        self.dismissVeneer()
    }

}
