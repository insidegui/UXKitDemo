//
//  FlickrResponse.swift
//  DevicePic
//
//  Created by Guilherme Rambo on 01/03/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

final class FlickrResponse<T: JSONRepresentable>: JSONRepresentable {
    
    var success = false
    
    var page = 0
    var pages = 0
    var perpage = 0
    var total = 0
    
    var items: [T] = []
    
    static func from(_ json: JSON) -> FlickrResponse<T>? {
        let response = FlickrResponse<T>()
        
        let responseData = json[T.responseName]
        
        response.success = (json["stat"].string == "ok")
        
        response.page = responseData["page"].intValue
        response.pages = responseData["pages"].intValue
        response.perpage = responseData["perpage"].intValue
        
        if let totalStr = responseData["total"].string {
            if let total = Int(totalStr) {
                response.total = total
            }
        }
        
        if let items = responseData[T.collectionName].array {
            response.items = items.flatMap { T.from($0) }
        }
                
        return response
    }
    
}
