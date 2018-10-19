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

class GSCollectionView: UIView {
    
    let collectionViewLayout = GSCollectionViewLayout()
    lazy var collectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionview.showsHorizontalScrollIndicator   = false
        collectionview.backgroundColor                  = .black
        collectionview.bounces                          = true
        collectionview.allowsSelection                  = false
        collectionview.delegate                         = self
        collectionview.dataSource                       = self
        collectionview.register(GSPinterestCell.self, forCellWithReuseIdentifier: GSPinterestCell.reuseIdentifier)
        return collectionview
    }()
    
    let square  = Datasource(titel: "Small", subtitle: "Subtitle", type: .square)
    let port    = Datasource(titel: "Portrait", subtitle: "subtitle", type: .portrait)
    let land    = Datasource(titel: "landscape", subtitle: "subt", type: .landscape)
    var dataSource = [Datasource]() {
        didSet {
            filterDataSourceToMatchLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        dataSource = [square, square, port, square, land, square, port, land, square, square, port, land, square, square, land, land]
    }
    
    func parentVCDidAppear() {
        setupSubviews()
        setupConstraints()
        filterDataSourceToMatchLayout()
    }
    
    func setupSubviews() {
        addSubview(collectionView)
        collectionViewLayout.delegate = self
    }
    func setupConstraints() {
        collectionView.fillSuperview(onlySafeArea: true)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    var addedElements       = [Datasource]()
    var remainingElements   = [Datasource]()
    var lastItem:             Datasource?
    
    func filterDataSourceToMatchLayout() {
        print("Function: \(#function), line: \(#line)")
        remainingElements = dataSource.shuffled()
        printTypeOf(array: remainingElements)
        
        repeat {
            if let lastItemType = lastItem?.type {
                if lastItemType == .square || lastItemType == .landscape {
                    getRandomItem()
                } else if lastItemType == .portrait || lastItemType == .square {
                    if oneColumnItemExists() {
                        getRandomOneColumnItem()
                    } else {
                        removeLastTenItems()
                    }
                }
            } else {
                getRandomItem()
            }
        } while !remainingElements.isEmpty
        
        
        DispatchQueue.main.async {
            print("reloading now")
            self.collectionViewLayout.cache.removeAll()
            self.collectionView.reloadData()
        }
        printTypeOf(array: addedElements)
    }
    
    func getRandomItem() {
        print("Function: \(#function), line: \(#line)")
        let randomNum = Int.random(in: 0 ..< remainingElements.count)
        let item = remainingElements[randomNum]
        addedElements.append(item)
        remainingElements.remove(at: randomNum)
        lastItem = addedElements.last
    }
    
    func getRandomOneColumnItem() {
        print("Function: \(#function), line: \(#line)")
        var item: Datasource
        var randomNum = 0
        repeat {
            randomNum = Int.random(in: 0 ..< remainingElements.count)
            item = remainingElements[randomNum]
        } while !(item.type == .square || item.type == .portrait)
        addedElements.append(item)
        remainingElements.remove(at: randomNum)
        lastItem = addedElements.last
    }
    
    func oneColumnItemExists() -> Bool {
        print("Function: \(#function), line: \(#line)")
        let oneColumnItemExists = remainingElements.contains(where: { (remainingItem) -> Bool in
            if remainingItem.type == cellType.square {
                return true
            } else if remainingItem.type == .portrait {
                return true
            } else { return false }
        })
        return oneColumnItemExists
    }
    
    func removeLastTenItems() {
        print("Function: \(#function), line: \(#line)")
        //First check if there are even 10 elements in the array
        var repeatCounter = 0
        if addedElements.count < 10 {
            repeatCounter = addedElements.count
        } else {
            repeatCounter = 10
        }
        //Then remove the last elements based on the counter
        for _ in 0..<repeatCounter {
            guard let item = addedElements.last else { return }
            addedElements.removeLast()
            remainingElements.append(item)
        }
        lastItem = addedElements.last
    }
    
    func printTypeOf(array: [Datasource]) {
        for item in array {
            print(item.type)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GSCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addedElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GSPinterestCell.reuseIdentifier, for: indexPath) as! GSPinterestCell
        cell.backgroundColor = .green
        cell.layer.cornerRadius = 10
        cell.configure(dataSource: addedElements[indexPath.row])
        return cell
    }
}


extension GSCollectionView: GSCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, typeForCellAtIndexPath indexPath: IndexPath) -> cellType {
        return addedElements[indexPath.row].type
    }
}
