//
//  ViewController.swift
//  Veneer
//
//  Created by Sam Watts on 01/24/2017.
//  Copyright (c) 2017 Sam Watts. All rights reserved.
//

import UIKit

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let padding: CGFloat = 10
        let columns: CGFloat = 3
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
        
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customViewWithTitle: "Show Overlay", target: self, action: #selector(ViewController.showOverlayFromBarButtonItem(_:)))
    }
    
    func showOverlayFromBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        print("show overlay from bar button item: \(barButtonItem)")
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = cellColors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("showing overlay highlighting cell at index path: \(indexPath)")
    }
}

