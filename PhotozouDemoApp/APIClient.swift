//
//  APIClient.swift
//  PhotozouDemoApp
//
//  Created by TakanoYuki on 2017/08/26.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class APIClient {
    let kEndpoint = "https://api.photozou.jp/rest/search_public.json"
    let kLimit = 50
    let kCopyright = "normal"
    
    private init() {}
    
    static let shared = APIClient()
    
    static func request(keyword: String, offset: Int, loadComplete:@escaping ([PhotoImageModel]) -> Void) {
        let param = [
            "keyword": keyword,
            "copyright": shared.kCopyright,
            "limit": shared.kLimit,
            "offset": offset
        ] as [String : Any]
        
        Alamofire.request(shared.kEndpoint, method: .get, parameters: param).responseJSON { response in
            var photoModels = [PhotoImageModel]()
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard let info = json["info"].dictionary else {
                    return loadComplete(photoModels)
                }
                guard let photos = info["photo"]?.array else {
                    return loadComplete(photoModels)
                }
                for photo in photos {
                    photoModels.append(PhotoImageModel(photo))
                }
                return loadComplete(photoModels)
            case .failure(_):
                return loadComplete(photoModels)
            }
        }
    }
}


