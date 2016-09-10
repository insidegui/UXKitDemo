//
//  SearchViewController.h
//  UXKit Demo
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "UXKit.h"

@import FlickrSearch;

@interface SearchViewController : UXCollectionViewController

@property (nonatomic, strong) NSMutableArray <Photo *> *photos;

@end
