//
//  ImageCache.swift
//  MacTube
//
//  Created by Guilherme Rambo on 29/12/15.
//  Copyright © 2015 Guilherme Rambo. All rights reserved.
//

import Cocoa

private let _sharedImageCache = ImageCache();

public final class ImageCache: NSObject {
    
    public class var sharedInstance: ImageCache {
        return _sharedImageCache
    }
    
    private struct Constants {
        static let noimageName = "noimage"
        static let imageExtension = "jpg"
        static let cachesDirName = "DevicePic"
    }
    
    private lazy var cacheDirectory: String? = {
        let dirs = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        
        let dir = "\(dirs[0])/\(Constants.cachesDirName)"
        
        if !FileManager.default.fileExists(atPath: dir) {
            do {
                try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: false, attributes: nil)
            } catch let error {
                print("Unable do create directory at path \(dir): \(error)")
                return nil
            }
        }
        
        return dir
    }()
    
    public func fetchImageWithURL(imageURL: String, callback: @escaping (String, NSImage?) -> ()) {
        guard let url = URL(string: imageURL) else { return }

        var components = url.pathComponents
        guard components.count > 2 else { return }
        components.removeFirst(1)
        
        let key = components.joined(separator: "-")
        guard let dir = cacheDirectory else { return }
        
        let path = "\(dir)/\(key).\(Constants.imageExtension)"
        
        guard !FileManager.default.fileExists(atPath: path) else {
            guard let image = NSImage(contentsOfFile: path) else { return }
            callback(imageURL, image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching image: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                callback(imageURL, NSImage(data: data))
            }
        }
        task.resume()
    }
    
}
