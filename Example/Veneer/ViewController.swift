//
//  ViewController.swift
//  Veneer
//
//  Created by Sam Watts on 01/24/2017.
//  Copyright (c) 2017 Sam Watts. All rights reserved.
//

import UIKit
import Veneer

class OverlayView: VeneerOverlayView {
    
    required init() {
        super.init()
        
        self.backgroundColor = .random
    }
}

class GridCollectionViewCell: UICollectionViewCell {
    
    static let gridReuseIdentifier: String = "gridCollectionViewCellReuseIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    private func commonInit() {
        self.contentView.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
}

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let horizontallyCompacy = collectionView.traitCollection.horizontalSizeClass == .compact
        let padding: CGFloat = 10
        let columns: CGFloat =  horizontallyCompacy ? 2 : 3
        let itemWidth = (collectionView.bounds.width - (padding * (columns + 1))) / columns
        
        let itemHeight = itemWidth
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        self.minimumLineSpacing = padding
        self.minimumInteritemSpacing = padding
        self.scrollDirection = .vertical
    }
}

class ViewController: UIViewController {
    
    //set of random colours as data source
    let cellColors: [UIColor] = Array<UIColor>(evaluating: { return .random }, count: 10)
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: GridCollectionViewFlowLayout())
        
        collectionView.register(GridCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: GridCollectionViewCell.gridReuseIdentifier)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //setup bar button item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customViewWithTitle: "Show Overlay", target: self, action: #selector(ViewController.showOverlayFromBarButtonItem))
    }
    
    func showOverlayFromBarButtonItem() {
        guard let barButtonItem = self.navigationItem.rightBarButtonItem else { return }
        print("show overlay from bar button item: \(barButtonItem)")
        
        let highlight = Highlight(
            viewType: .barButtonItem(barButtonItem: barButtonItem),
            borderInsets: UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5),
            lineDashColor: .blue,
            lineDashPattern: [5, 5],
            lineDashWidth: 3
        )

        self.showVeneer(withHighlight: highlight, overlayViewType: OverlayView.self)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.gridReuseIdentifier, for: indexPath) as! GridCollectionViewCell
        
        cell.backgroundColor = cellColors[indexPath.item]
        cell.label.text = "Tap to highlight"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("showing overlay highlighting cell at index path: \(indexPath)")
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        self.showVeneer(withHighlight: Highlight(viewType: .view(view: cell)), overlayViewType: OverlayView.self)
    }
}

