//
//  BookmarksViewController.swift
//  Veneer
//
//  Created by Sam Watts on 09/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Veneer

class BookmarksViewController: UIViewController {
    
    let firstView = UIView()
    let secondView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
        
        firstView.backgroundColor = .random
        secondView.backgroundColor = .random
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(BookmarksViewController.showCombinationOverlay))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        firstView.frame = CGRect(x: 100, y: 100, width: 200, height: 300)
        secondView.frame = CGRect(x: 150, y: 150, width: 200, height: 100)
    }
    
    func showCombinationOverlay() {
        let highlight = Highlight(viewType: .viewUnion(views: [firstView, secondView]))
        self.showVeneer(withHighlight: highlight)
    }

}
