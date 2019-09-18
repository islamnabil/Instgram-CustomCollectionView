//
//  InstagramLayout.swift
//  CustomCollectionView
//
//  Created by Islam Elgaafary on 9/17/19.
//  Copyright © 2019 islam. All rights reserved.
//

import UIKit

protocol InstagramLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath , Photo:Bool) -> Bool
}


class InstagramLayout: UICollectionViewLayout {

    // 1
    weak var delegate: InstagramLayoutDelegate?
    // 2
    private let numberOfColumns = 3
    private let cellPadding: CGFloat = 3
    
    // 3
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    // 4
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // 5
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        // 1
        guard
            cache.isEmpty,
            let collectionView = collectionView
            else {
                return
        }
        // 2
        var columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        // 3
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4
            let photo = delegate?.collectionView(
                collectionView,
                heightForPhotoAtIndexPath: indexPath, Photo: true)
            
            var photoHeight = CGFloat()
            
            var height = CGFloat()
            
            if photo == false {
                photoHeight = 300
                columnWidth =  contentWidth / 2
                height = photoHeight
                xOffset = [CGFloat]()
                
                for column in 0..<numberOfColumns {
                    xOffset.append(CGFloat(column) * columnWidth)
                }
                
            }else {
                photoHeight = 150
                 height = cellPadding * 2 + photoHeight
                xOffset = [CGFloat]()
                columnWidth =  contentWidth / 3
                for column in 0..<numberOfColumns {
                    xOffset.append(CGFloat(column) * columnWidth)
                }
            }
            
            
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
            
            // Loop through the cache and look for items in the rect
            for attributes in cache {
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
            return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
    }
    
    
}
