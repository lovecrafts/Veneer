//
//  Foundation+Helpers.swift
//  Veneer
//
//  Created by Sam Watts on 24/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

extension Array {
    
    init(evaluating: () -> Element, count: Int) {
        self = (0..<count).map { _ in return evaluating() }
    }
}
