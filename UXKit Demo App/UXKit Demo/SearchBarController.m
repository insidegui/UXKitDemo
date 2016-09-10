//
//  SearchBarController.m
//  UXKit Demo
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "SearchBarController.h"

#import "AppDelegate.h"

@interface SearchBarController ()

@property (nonatomic, strong) NSSearchField *searchField;

@end

@implementation SearchBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.uxView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uxView.widthAnchor constraintEqualToConstant:200.0].active = YES;
    _searchField = [NSSearchField new];
    _searchField.translatesAutoresizingMaskIntoConstraints = NO;
    _searchField.sendsWholeSearchString = YES;
    [self.uxView addSubview:_searchField];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_searchField);
    [self.uxView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_searchField]|" options:0 metrics:nil views:views]];
    [self.uxView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_searchField]|" options:0 metrics:nil views:views]];
    
    _searchField.action = @selector(search:);
}

@end
