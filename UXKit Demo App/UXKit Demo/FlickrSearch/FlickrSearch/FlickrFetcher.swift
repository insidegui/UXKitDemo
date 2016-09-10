//
//  FlickrFetcher.swift
//  FlickrSearch
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa
import ReactiveCocoa

public final class FlickrFetcher: NSObject {

    private let credentials: FlickrCredentials
    
    public init(credentials: FlickrCredentials) {
        self.credentials = credentials
        
        super.init()
    }
    
    private let scheduler = UIScheduler()
    
    public func search(for query: String, completionHandler: @escaping ([Photo]?, NSError?) -> ()) {
        FlickrAPI.search(for: query, with: credentials).observe(on: scheduler).startWithResult { result in
            if result.error != nil {
                completionHandler(nil, result.error)
            } else {
                completionHandler(result.value!?.items, nil)
            }
        }
    }
    
}
