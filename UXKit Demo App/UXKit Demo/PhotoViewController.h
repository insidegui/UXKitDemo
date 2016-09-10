//
//  PhotoViewController.h
//  UXKit Demo
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

@import Cocoa;

@import FlickrSearch;

#import "UXViewController.h"

@interface PhotoViewController : UXViewController

- (instancetype)initWithPhoto:(Photo *)photo;

@property (nonatomic, strong) Photo *photo;

@end
