//
//  PhotoZouManager.swift
//  PhotozouDemoApp
//
//  Created by TakanoYuki on 2017/08/26.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import Foundation

final class PhotoZouManager {
    private init() {}
    static let shared = PhotoZouManager()
    
    func getPhotoZouModels(keyword: String, offset: Int, loadComplete:@escaping (_ photoModels: [PhotoImageModel]) -> Void) {
        APIClient.request(keyword: keyword, offset: offset, loadComplete: {
            photoModels in
            loadComplete(photoModels)
        })
    }
}
