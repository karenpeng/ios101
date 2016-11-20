//
//  FlickrService.swift
//  fakeflickr
//
//  Created by karenpeng on 11/19/16.
//  Copyright © 2016 karenpeng. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class FlickrService {
    
    let url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&text=kittens"
    
    func httpGet(callback: @escaping (Any?, Any?) -> Void) {
        Alamofire.request(url).responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            print("Error: \(response.error)")
//            
//            if response.error {
//                callback(nil, response.error)
//            } else {
//                let JSON = response.result.value
//                print("JSON: \(JSON)")
//                callback(JSON, nil)
//
//            }
            let JSON = response.result.value
            //print("JSON: \(JSON)")
            callback(JSON, nil)
        }
    }
    
    func makePhotoUrlString(farm: Any, server: Any, id: Any, secret: Any) -> String {
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    func generatePhotoUrls(data: Any) -> [String] {
        let json = JSON(data)
        return json["photos"]["photo"].arrayValue.map({
            (item: JSON) -> String in
            return makePhotoUrlString(farm: item["farm"], server: item["server"], id: item["id"], secret: item["secret"])
        })
    }
    
}
