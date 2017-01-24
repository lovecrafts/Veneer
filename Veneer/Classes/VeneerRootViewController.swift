//
//  VeneerRootViewController.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

class VeneerRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let dismissTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VeneerRootViewController.dismissVeneer))
        self.view.addGestureRecognizer(dismissTapGestureRecognizer)
    }
    
    func dismissVeneer() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.window?.alpha = 0.0
        }) { _ in
            self.view.window?.resignKey()
        }
    }

}
