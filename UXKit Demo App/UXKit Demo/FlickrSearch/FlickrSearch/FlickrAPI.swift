//
//  FlickrAPI.swift
//  DevicePic
//
//  Created by Guilherme Rambo on 01/03/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation
import ReactiveCocoa

class FlickrAPI {
    
    private struct URLs {
        static let apiendpoint = "https://api.flickr.com/services/rest/?"
        static let searchFormat = "\(apiendpoint)method=flickr.photos.search&api_key=%@&format=json&nojsoncallback=1&tags=%@&extras=date_taken,owner_name,views,media,url_l"
    }
    
    enum Route {
        
        case Search(String)
        
        func url(with credentials: FlickrCredentials) -> URL {
            switch self {
            case .Search(let query):
                let urlString = String(format: URLs.searchFormat, credentials.key, query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                    
                return URL(string: urlString)!
            }
        }
        
    }
    
    class func search(for query: String, with credentials: FlickrCredentials) -> SignalProducer<FlickrResponse<Photo>?, NSError> {
        let request = URLRequest(url: Route.Search(query).url(with: credentials))
        
        return URLSession.shared.rac_data(with: request).retry(upTo: 2).map { (data, response) -> FlickrResponse<Photo>? in
            return FlickrResponse<Photo>.from(JSON(data: data))
        }
    }
    
}
