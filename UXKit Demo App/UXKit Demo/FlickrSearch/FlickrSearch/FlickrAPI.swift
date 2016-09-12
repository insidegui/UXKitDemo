//
//  FlickrAPI.swift
//  DevicePic
//
//  Created by Guilherme Rambo on 01/03/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

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
    
    class func search(for query: String, with credentials: FlickrCredentials, completion: @escaping (FlickrResponse<Photo>?, Error?) -> ()) {
        let request = URLRequest(url: Route.Search(query).url(with: credentials))
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            completion(FlickrResponse<Photo>.from(JSON(data: data)), nil)
        }.resume()
    }
    
}
