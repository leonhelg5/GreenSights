//
//  GSCollectionViewLayout.swift
//  GreenSights
//
//  Created by Leon Helg on 17.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//  Inspired by: https://www.raywenderlich.com/392-uicollectionview-custom-layout-tutorial-pinterest

import UIKit

protocol GSCollectionViewLayoutDelegate: class {
    
    func collectionView(_ collectionView:UICollectionView, typeForCellAtIndexPath indexPath:IndexPath) -> cellType
}

/**
 Note: As prepare() is called whenever the collection view's layout is invalidated, there are many situations in a typical implementation where you might need to recalculate attributes here. For example, the bounds of the UICollectionView might change - such as when the orientation changes - or items may be added or removed from the collection. These cases are out of scope for this tutorial, but it's important to be aware of them in a non-trivial implementation.
 */

class GSCollectionViewLayout: UICollectionViewLayout {
    // 1 This keeps a reference to the delegate.
    weak var delegate: GSCollectionViewLayoutDelegate!
    
    // 2 These are two properties for configuring the layout: the number of columns and the cell padding.
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 8
    
    // 3 This is an array to cache the calculated attributes. When you call prepare(), you’ll calculate the attributes for all items and add them to the cache. When the collection view later requests the layout attributes, you can be efficient and query the cache instead of recalculating them every time.
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    // 4 This declares two properties to store the content size. contentHeight is incremented as photos are added, and contentWidth is calculated based on the collection view width and its content inset.
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // 5 This overrides the collectionViewContentSize method to return the size of the collection view’s contents. You use both contentWidth and contentHeight from previous steps to calculate the size.
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    
    
    override func prepare() {
        // 1 You only calculate the layout attributes if cache is empty and the collection view exists.
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        // 2 This declares and fills the xOffset array with the x-coordinate for every column based on the column widths. The yOffset array tracks the y-position for every column. You initialize each value in yOffset to 0, since this is the offset of the first item in each column.
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        // 3 This loops through all the items in the first section, as this particular layout has only one section.
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4 This is where you perform the frame calculation. width is the previously calculated cellWidth, with the padding between cells removed. You ask the delegate for the type of the photo and calculate the frame height and width based on these values and the predefined cellPadding for the top and bottom. You then combine this with the x and y offsets of the current column to create the insetFrame used by the attribute.
            let type = delegate.collectionView(collectionView, typeForCellAtIndexPath: indexPath)
            var height: CGFloat = 0
            var width: CGFloat = 0
            
            switch type {
            case .portrait:
                height = contentWidth
                width  = columnWidth
            case .landscape:
                if column == 0 {
                    height = columnWidth
                    width  = contentWidth
                } else {
                    //TODO: safe cell for later or implement sort func
                    height = columnWidth
                    width  = columnWidth
                }
            case .square:
                if column == 0 {
                    height = contentWidth
                    width  = contentWidth
                } else {
                    height = columnWidth
                    width  = columnWidth
                }
            }
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5 This creates an instance of UICollectionViewLayoutAttribute, sets its frame using insetFrame and appends the attributes to cache.
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            
            
            // 6 This expands contentHeight to account for the frame of the newly calculated item. It then advances the yOffset for the current columns based on the frame. Finally, it advances the column so that the next item will be placed in the correct column.
            contentHeight = max(contentHeight, frame.maxY)
            
            yOffset[column] = yOffset[column] + height
            if column == 0 {
                //Big square or landscape take both columns:
                if type == .square || type == .landscape {
                    yOffset[1] = yOffset[1] + height
                    column = 0
                } else {
                    column = 1
                }
            } else {
                if yOffset[0] == yOffset[1] {
                    column = 0
                }
            }
        }
    }
    
    
    
    
    /**
     Here you iterate through the attributes in cache and check if their frames intersect with rect, which is provided by the collection view. You add any attributes with frames that intersect with that rect to layoutAttributes, which is eventually returned to the collection view.
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    
    /**
     Here you simply retrieve and return from cache the layout attributes which correspond to the requested indexPath.
     */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
