//
//  CollectionViewFooter.swift
//  PhotozouDemoApp
//
//  Created by TakanoYuki on 2017/08/26.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import UIKit

class CollectionViewFooter: UICollectionReusableView {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let kWarnSearchBarText = "検索キーワードを設定して下さい"
    let kNoData = "これ以上データがありません"
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//    }
    
    override func awakeFromNib() {
        self.indicator.hidesWhenStopped = true
    }
    
    func startIndicator() {
        self.label.isHidden = true
        self.indicator.startAnimating()
    }
    
    func stopIndicator() {
        self.indicator.stopAnimating()
    }
    
    func showLabel(isSearched: Bool) {
        if isSearched {
            self.label.text = kNoData
        } else {
            self.label.text = kWarnSearchBarText
        }
        self.label.isHidden = false
    }
}
