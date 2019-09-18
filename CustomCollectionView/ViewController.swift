//
//  ViewController.swift
//  CustomCollectionView
//
//  Created by Islam Elgaafary on 9/17/19.
//  Copyright © 2019 islam. All rights reserved.
//

import UIKit

class ViewController: UIViewController , GridLayoutDelegate {

    @IBOutlet weak var InstagramCollection: UICollectionView!
    @IBOutlet weak var gridLayout: GridLayout!
    var arrInstaBigCells = [Int]()

    var arrImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        InstagramCollection.delegate = self
        InstagramCollection.dataSource = self
        
        //Preparing array Of images
        arrImages = Array(repeatElement(#imageLiteral(resourceName: "tmp"), count: 99))
        
        arrInstaBigCells.append(1)
        var tempStorage = false
        for _ in 1...21 {
            if(tempStorage){
                arrInstaBigCells.append(arrInstaBigCells.last! + 10)
            } else {
                arrInstaBigCells.append(arrInstaBigCells.last! + 8)
            }
            tempStorage = !tempStorage
        }
        
        print(arrInstaBigCells)
        InstagramCollection.backgroundColor = .white
        InstagramCollection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        InstagramCollection.contentOffset = CGPoint(x: -10, y: -10)
        
        gridLayout.delegate = self
        gridLayout.itemSpacing = 3
        gridLayout.fixedDivisionCount = 3
        
        
    }


}


extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 99
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == InstagramCollection {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramCollCell", for: indexPath) as? InstagramCollCell {
                
                
                
                return cell
            }
            
            return InstagramCollCell()
        }
        
        
        return UICollectionViewCell()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scaleForItem(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, atIndexPath indexPath: IndexPath) -> UInt {
        if(arrInstaBigCells.contains(indexPath.row) || (indexPath.row == 1)){
            return 2
        } else {
            return 1
        }
    }
    
    func itemFlexibleDimension(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, fixedDimension: CGFloat) -> CGFloat {
        return fixedDimension
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
//
//        return CGSize(width: InstagramCollection.frame.width/2, height: itemSize)
//    }
    
}


//extension ViewController: InstagramLayoutDelegate {
//    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, Photo: Bool) -> Bool {
//        if indexPath.row == 0  {
//            return false
//        }
//
//        return true
//    }
//
////    func collectionView(
////        _ collectionView: UICollectionView,
////        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
////        return CGFloat(heights[indexPath.row])
////
////    }
//}


