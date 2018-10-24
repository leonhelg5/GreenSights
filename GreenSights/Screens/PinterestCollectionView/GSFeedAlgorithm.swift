//
//  GSFeedAlgorithm.swift
//  GreenSights
//
//  Created by Leon Helg on 22.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import Foundation

extension GSCollectionView {
    func filterNextElementsOfDataSource(_ amount: Int) {
        remainingElements = Array(dataSource.prefix(amount))
        remainingElements.shuffle()
        repeat {
            if lastItem == nil {
                getRandomItem()
            } else {
                if twoColumnItemCanBeSpawned() {
                    getRandomItem()
                } else {
                    if oneColumnItemExists() {
                        getRandomSingleColumnItem()
                    } else {
                        removeLastTenItems()
                    }
                }
            }
        } while !remainingElements.isEmpty
        
        setNeedsLayout()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        layoutIfNeeded()
    }
    
    
    //MARK: Generate Methods
    func getRandomItem() {
        let randomNum = Int.random(in: 0 ..< remainingElements.count)
        var item = remainingElements[randomNum]
        if item.type == .square {
            item.size = smallOrBigSquare()
        }
        addItemToArray(item: item, index: randomNum)
    }
    
    func getRandomSingleColumnItem() {
        var item: Datasource
        var randomNum = 0
        repeat {
            randomNum = Int.random(in: 0 ..< remainingElements.count)
            item = remainingElements[randomNum]
        } while !(item.type == .square || item.type == .portrait)
        
        if item.type == .square {
            item.size = .smallSquare
        }
        addItemToArray(item: item, index: randomNum)
    }
    
    
    //MARK: Decider Methods
    /**
     I dont want:
     * Big Square At the beginning
     * Two Big Squares in a row
     * Three Small Squares in a row (disabled atm)
     */
    func smallOrBigSquare() -> cellSize {
        guard let lastItemSize = lastItem?.size else { return
            .smallSquare
        }
        if lastItemSize == .bigSquare {
            return .smallSquare
        }
        guard let secondLastItemSize = secondLastItem?.size else {
            if lastItemSize == .portrait || lastItemSize == .smallSquare {
                return .smallSquare
            } else {
                return Bool.random() ? .bigSquare : .smallSquare
            }
        }
        if lastItemSize == .smallSquare && secondLastItemSize == .smallSquare {
            return .bigSquare
        }
        if secondLastItemSize == .landscape || secondLastItemSize == .bigSquare {
            return .smallSquare
        }
        if (lastItemSize == .portrait || lastItemSize == .smallSquare) && (secondLastItemSize == .landscape || secondLastItemSize == .bigSquare) {
            return .smallSquare
        }
        return Bool.random() ? .bigSquare : .smallSquare
    }
    
    
    //MARK: Check IF <..> Methods
    func oneColumnItemExists() -> Bool {
        let oneColumnItemExists = remainingElements.contains(where: { (remainingItem) -> Bool in
            if remainingItem.type == cellType.square {
                return true
            } else if remainingItem.type == .portrait {
                return true
            } else { return false }
        })
        return oneColumnItemExists
    }
    
    
    //We dont want more than two landscapes in a row
    func twoColumnItemCanBeSpawned() -> Bool {
        guard let lastItemSize = lastItem?.size else { return true }
        //Because the big Square and the Landscape take two columns, landscape can be spawned
        guard let secondLastItemSize = secondLastItem?.size else {
            if lastItemSize == .bigSquare || lastItemSize == .landscape {
                return true
            } else {
                return false
            }
        }
        if (lastItemSize == .portrait && secondLastItemSize == .smallSquare) {
            return false
        } else if (lastItemSize == .smallSquare && secondLastItemSize == .portrait) {
            return false
        } else if (lastItemSize == .smallSquare && (secondLastItemSize == .bigSquare || secondLastItemSize == .landscape)) {
            return false
        } else if (lastItemSize == .portrait && (secondLastItemSize == .bigSquare || secondLastItemSize == .landscape)) {
            return false
        } else if (lastItemSize == .landscape && secondLastItemSize == .landscape) {
            return false
        }
        guard let thirdLastItemSize = thirdLastItem?.size else { return true }
        if (lastItemSize == .portrait && secondLastItemSize == .portrait && (thirdLastItemSize == .smallSquare || thirdLastItemSize == .portrait)) {
            return false //not 100% accurate
        }
        
        return true
    }
    
    
    //MARK: - Setter / Remover Methods
    func addItemToArray(item: Datasource, index: Int) {
        addedElements.append(item)
        remainingElements.remove(at: index)
        setLastItems()
    }
    
    func setLastItems() {
        if addedElements.count >= 1 {
            lastItem = addedElements[addedElements.count-1]
        } else { lastItem = nil}
        if addedElements.count >= 2 {
            secondLastItem = addedElements[addedElements.count-2]
        } else { secondLastItem = nil}
        if addedElements.count >= 3 {
            thirdLastItem = addedElements[addedElements.count-3]
        } else { thirdLastItem = nil}
    }
    
    func removeLastTenItems() {
        //First check if there are even 10 elements in the array
        let repeatCounter = addedElements.count < 10 ? addedElements.count : 10
        
        //Then remove the last elements based on the counter
        for _ in 0..<repeatCounter {
            guard let item = addedElements.last else { return }
            addedElements.removeLast()
            remainingElements.append(item)
        }
        remainingElements.shuffle()
        setLastItems()
    }
    
    func resetLayout() {
        lastItem = nil
        secondLastItem = nil
        thirdLastItem = nil
        addedElements.removeAll()
        remainingElements.removeAll()
        collectionView.contentSize = .zero
        filterNextElementsOfDataSource(15)
    }

}
