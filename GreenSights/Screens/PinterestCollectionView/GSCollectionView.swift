//
//  GSCollectionView.swift
//  GreenSights
//
//  Created by Leon Helg on 17.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

enum cellType {
    case square
    case portrait
    case landscape
}

struct Datasource {
    var titel: String
    var subtitle: String
    var type: cellType
}

//ELENA
class GSCollectionView: UIView {
    
    let cellId = "cellId" //TODO
    lazy var collectionView: UICollectionView = {
        let layout = GSCollectionViewLayout()
        layout.delegate = self
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.showsHorizontalScrollIndicator   = false
        collectionview.backgroundColor                  = .black
        collectionview.bounces                          = true
        collectionview.allowsSelection                  = false
        collectionview.delegate                         = self
        collectionview.dataSource                       = self
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionview
    }()
    
    let square  = Datasource(titel: "Small", subtitle: "Subtitle", type: .square)
    let port    = Datasource(titel: "Portrait", subtitle: "subtitle", type: .portrait)
    let land    = Datasource(titel: "landscape", subtitle: "subt", type: .landscape)
    var dataSource = [Datasource]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        dataSource = [square, square, port, square, land, square, port, land, square, square, port, land, square, square, land, land]
    }
    
    func parentVCDidAppear() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(collectionView)
    }
    func setupConstraints() {
        collectionView.fillSuperview(onlySafeArea: true)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GSCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .green
        cell.layer.cornerRadius = 10
        return cell
    }
}


extension GSCollectionView: GSCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, typeForCellAtIndexPath indexPath: IndexPath) -> cellType {
        return dataSource[indexPath.row].type
    }
}
