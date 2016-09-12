//
//  FlickrFetcher.swift
//  FlickrSearch
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa

public final class FlickrFetcher: NSObject {

    private let credentials: FlickrCredentials
    
    public init(credentials: FlickrCredentials) {
        self.credentials = credentials
        
        super.init()
    }
    
    public func search(for query: String, completionHandler: @escaping ([Photo]?, Error?) -> ()) {
        FlickrAPI.search(for: query, with: credentials) { response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(response?.items, nil)
                }
            }
        }
    }
    
}
