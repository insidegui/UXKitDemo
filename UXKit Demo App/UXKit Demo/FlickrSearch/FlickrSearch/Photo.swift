//
//  Photo.swift
//  DevicePic
//
//  Created by Guilherme Rambo on 01/03/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

enum PhotoSize: String {
    
    /// s small square 75x75
    case square75 = "s"
    
    /// q large square 150x150
    case square150 = "q"
    
    /// t thumbnail, 100 on longest side
    case thumbnail100 = "t"
    
    /// m small, 240 on longest side
    case small240 = "m"
    
    /// n small, 320 on longest side
    case small360 = "n"
    
    /// z medium 640, 640 on longest side
    case medium640 = "z"
    
    /// c medium 800, 800 on longest side†
    case medium800 = "c"
    
    /// b large, 1024 on longest side*
    case large1024 = "b"
    
    /// h large 1600, 1600 on longest side†
    case large1600 = "h"
    
    /// k large 2048, 2048 on longest side†
    case large2048 = "k"
    
    /// o original image, either a jpg, gif or png, depending on source format
    case original = "o"

}

public final class Photo: NSObject, JSONRepresentable {
    
    static var responseName: String {
        return "photos"
    }
    
    static var collectionName: String {
        return "photo"
    }
    
    public var id = ""
    
    public var ownerId = ""
    public var ownerName = ""
    
    public var secret = ""
    public var server = 0
    public var farm = 0
    
    public var title = ""
    public var dateTaken = ""
    public var views = 0
    
    private var baseURLFormat: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_%@.jpg"
    }
    
    func getURL(for size: PhotoSize) -> String {
        return String(format: baseURLFormat, size.rawValue)
    }
    
    public var thumbnailURL: String {
        return getURL(for: .square75)
    }
    
    public var largeURL: String {
        return getURL(for: .large1600)
    }
    
    var width = 0
    var height = 0
    
    static func from(_ json: JSON) -> Photo? {
        let photo = Photo()
        
        if let id = json["id"].string {
            photo.id = id
        }
        
        if let ownerId = json["owner"].string {
            photo.ownerId = ownerId
        }
        
        if let ownerName = json["ownername"].string {
            photo.ownerName = ownerName
        }
        
        if let secret = json["secret"].string {
            photo.secret = secret
        }
        
        if let serverStr = json["server"].string {
            if let server = Int(serverStr) {
                photo.server = server
            }
        }
        
        photo.farm = json["farm"].intValue
        
        if let title = json["title"].string {
            photo.title = title
        }
        
        if let dateTaken = json["datetaken"].string {
            photo.dateTaken = dateTaken
        }
        
        if let viewsStr = json["views"].string {
            if let views = Int(viewsStr) {
                photo.views = views
            }
        }
        
        return photo
    }
    
}
