//: Playground - noun: a place where people can play

import UIKit
@testable import Veneer
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let highlight = Highlight.view(view: UIView(frame: .zero))

//set in container view to see edges of highlight view
let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
containerView.backgroundColor = .lightGray

let highlightView = HighlightView()
highlightView.frame = CGRect(x: 50, y: 50, width: 300, height: 300)

highlightView.backgroundColor = .white

//set container view as live view
containerView.addSubview(highlightView)
PlaygroundPage.current.liveView = containerView
