//
//  PhotoViewController.m
//  UXKit Demo
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "PhotoViewController.h"

#import "UXKit.h"
#import "AMFlippedClipView.h"

#import "AppDelegate.h"

@interface PhotoViewController ()

@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) UXImageView *imageView;

@end

@implementation PhotoViewController

- (instancetype)initWithPhoto:(Photo *)photo
{
    self = [super init];
    
    _photo = photo;
    
    return self;
}

- (void)setPhoto:(Photo *)photo
{
    _photo = photo;
    
    [self updateUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [NSScrollView new];
    self.scrollView.contentView = [AMFlippedClipView new];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.hasVerticalScroller = YES;
    self.scrollView.hasHorizontalScroller = YES;
    
    [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    self.imageView = [UXImageView new];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self updateUI];
}

- (void)updateUI
{
    if (self.photo == nil) return;
    
    [NSApp sendAction:@selector(showLoadingStatus) to:nil from:self];
    
    [[ImageCache sharedInstance] fetchImageWithURLWithImageURL:self.photo.largeURL callback:^(NSString *imageURL, NSImage *image) {
        self.imageView.image = image;
        self.scrollView.documentView = self.imageView;
        [NSApp sendAction:@selector(hideLoadingStatus) to:nil from:self];
    }];
}

- (void)viewWillDisappear
{
    [super viewWillDisappear];
    
    [NSApp sendAction:@selector(hideLoadingStatus) to:nil from:self];
}

@end
