//
//  Dwifft+UXKit.swift
//  UXKit Demo
//
//  Created by Jack Flintermann on 3/13/15. 
//  Adapted to UXKit by Guilherme Rambo on 9/10/16.
//  Copyright (c) 2015 Places. All rights reserved.
//

import Cocoa
    
final class CollectionViewDiffCalculator<T: Equatable> {
    
    weak var receptor: CollectionViewDataHandlerReceptor?
    
    init(receptor: CollectionViewDataHandlerReceptor, initialRows: [T] = []) {
        self.receptor = receptor
        self.rows = initialRows
    }
    
    /// Right now this only works on a single section of a collectionView. If your collectionView has multiple sections, though, you can just use multiple CollectionViewDiffCalculators, one per section, and set this value appropriately on each one.
    var sectionIndex: Int = 0
    
    /// Change this value to trigger animations on the collection view.
    var rows : [T] {
        didSet {
            let oldRows = oldValue
            let newRows = self.rows
            let diff = oldRows.diff(newRows)
            if (diff.results.count > 0) {
                let insertionIndexPaths = diff.insertions.map({ NSIndexPath(forItem: $0.idx, inSection: self.sectionIndex) })
                let deletionIndexPaths = diff.deletions.map({ NSIndexPath(forItem: $0.idx, inSection: self.sectionIndex) })
                
                receptor?.performBatchUpdates({ () -> Void in
                    self.receptor?.insertItemsAtIndexPaths(NSArray(array: insertionIndexPaths))
                    self.receptor?.deleteItemsAtIndexPaths(NSArray(array: deletionIndexPaths))
                }, completion: nil)
            }
            
        }
    }
    
}
