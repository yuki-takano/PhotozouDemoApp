//
//  PhotoImageModel.swift
//  PhotozouDemoApp
//
//  Created by TakanoYuki on 2017/08/26.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotoImageModel {
    var id: String = ""
    var title: String = ""
    var imageUrl: String = ""
    var originalWidth: CGFloat = 0.0
    var originalHeight: CGFloat = 0.0
    
    init() {}
    
    init(_ data: JSON) {
        parseJson(data)
    }
    
    private func parseJson(_ data: JSON) {
        if let id = data["photo_id"].string {
            self.id = id
        }
        
        if let title = data["photo_title"].string {
            self.title = title
        }
        
        if let imageUrl = data["image_url"].string {
            self.imageUrl = imageUrl
        }
        
        if let originalWidth = data["original_width"].int {
            self.originalWidth = CGFloat(originalWidth)
        }
        
        if let originalHeight = data["original_height"].int {
            self.originalHeight = CGFloat(originalHeight)
        }


    }
}
