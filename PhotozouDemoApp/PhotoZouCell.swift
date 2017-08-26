//
//  PhotoZouCell.swift
//  PhotozouDemoApp
//
//  Created by TakanoYuki on 2017/08/26.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoZouCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setImage(url: String) {
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "no_image"))
    }
    
}
