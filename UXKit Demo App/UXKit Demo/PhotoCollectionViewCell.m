//
//  PhotoCollectionViewCell.m
//  UXKit Demo
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

#import "UXKit.h"

@interface PhotoCollectionViewCell ()

@property (nonatomic, strong) UXImageView *imageView;

@end

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    
    [self buildUI];
    
    [self addObserver:self forKeyPath:@"photo" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:NULL];
    
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"photo"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"photo"]) {
        [self updateUI];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)buildUI
{
    self.imageView = [[UXImageView alloc] initWithFrame:self.bounds];
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:self.imageView];
    [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    
    self.imageView.image = [NSImage imageNamed:@"noimage"];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageView.image = [NSImage imageNamed:@"noimage"];
}

- (void)updateUI
{
    if (!self.photo) return;
    
    [[ImageCache sharedInstance] fetchImageWithURLWithImageURL:self.photo.thumbnailURL callback:^(NSString *imageURL, NSImage *image) {
        if (![imageURL isEqualToString:self.photo.thumbnailURL]) return;
        
        self.imageView.image = image;
    }];
}

@end
