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

}
