//
//  JSONRepresentable.swift
//  DevicePic
//
//  Created by Guilherme Rambo on 01/03/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

protocol JSONRepresentable {
    
    /// The key for the response dictionary which will contain the collection of data
    static var responseName: String { get }
    
    /// The key for an array of the model when It appears in a response
    static var collectionName: String { get }
    
    /// Must return an instance of the model created by unmarshalling from JSON
    static func from(_ json: JSON) -> Self?
    
}

extension JSONRepresentable {
    
    static var responseName: String {
        return ""
    }
    
    static var collectionName: String {
        return ""
    }
    
}
