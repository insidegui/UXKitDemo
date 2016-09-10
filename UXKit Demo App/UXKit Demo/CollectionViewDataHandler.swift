//
//  CollectionViewDataHandler.swift
//  UXKit Demo
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa
import FlickrSearch

@objc protocol CollectionViewDataHandlerReceptor: NSObjectProtocol {
    
    func reloadData()
    func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?)
    func insertItemsAtIndexPaths(_ at: NSArray)
    func deleteItemsAtIndexPaths(_ at: NSArray)
    func reloadItemsAtIndexPaths(_ at: NSArray)
    
}

class CollectionViewDataHandler: NSObject {

    typealias CollectionViewUpdateWrapperBlock = (() -> (), (() -> ())?) -> ()
    typealias CollectionViewUpdateBlock = ([IndexPath]) -> ()
    
    private var diffCalculator: CollectionViewDiffCalculator<Photo>?
    
    var photos = [Photo]() {
        didSet {
            if let diffCalculator = diffCalculator {
                diffCalculator.rows = photos
            } else {
                diffCalculator = CollectionViewDiffCalculator<Photo>(receptor: self.receptor!, initialRows: self.photos)
            }
//            if oldValue.count == 0 {
//                self.receptor?.performBatchUpdates({ 
//                    let indexPaths = (0..<self.photos.count).map({ NSIndexPath(forItem: $0, inSection: 0) })
//                    self.receptor?.insertItemsAtIndexPaths(NSArray(array: indexPaths))
//                    }, completion: nil)
//                return
//            }
        }
    }
    
    private weak var receptor: CollectionViewDataHandlerReceptor?
    
    init(receptor: CollectionViewDataHandlerReceptor) {
        self.receptor = receptor
    }
    
}
