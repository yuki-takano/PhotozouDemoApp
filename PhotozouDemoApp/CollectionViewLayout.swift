//
//  CollectionViewLayout.swift
//  PhotozouDemoApp
//
//  Created by TakanoYuki on 2017/08/26.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import UIKit

public extension UICollectionView {
    public func adaptGrid(_ gridPerRowNum: Int, gridLineSpace space: CGFloat, sectionInset inset: UIEdgeInsets) {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        let length = self.frame.width - (space * CGFloat(gridPerRowNum - 1)) - (inset.left + inset.right)
        let size = length / CGFloat(gridPerRowNum)
        guard size > 0 else {
            return
        }
        layout.itemSize = CGSize(width: size, height: size)
        
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = inset
        layout.invalidateLayout()
    }
}
