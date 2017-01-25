//
//  HighlightView.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

class HighlightView: UIView {
    
    @available(*, unavailable, message: "init(frame:) is unavailable, use init(highlight:) instead")
    override init(frame: CGRect) { fatalError() }
    
    @available(*, unavailable, message: "init?(coder:) is unavailable, use init(highlight:) instead")
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    init(highlight: Highlight) {
        super.init(frame: .zero)
    }
}
