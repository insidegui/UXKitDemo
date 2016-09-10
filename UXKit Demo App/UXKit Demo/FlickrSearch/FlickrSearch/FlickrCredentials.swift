//
//  FlickrCredentials.swift
//  DevicePic
//
//  Created by Guilherme Rambo on 01/03/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

public final class FlickrCredentials: NSObject {
    
    var key: String
    var secret: String
    
    public init(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }
    
}
