//
//  SearchBarItem.m
//  UXKit Demo
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "SearchBarItem.h"

#import "SearchBarController.h"

@implementation SearchBarItem

- (instancetype)init
{
    self = [super initWithContentViewController:[SearchBarController new]];
    
    return self;
}

@end
