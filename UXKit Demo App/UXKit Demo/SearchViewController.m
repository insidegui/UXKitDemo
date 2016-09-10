//
//  SearchViewController.m
//  UXKit Demo
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "SearchViewController.h"

#import "UXKit_Demo-Swift.h"

#import "AppDelegate.h"

#import "PhotoViewController.h"

#import "PhotosFlowLayout.h"
#import "PhotoCollectionViewCell.h"

#import "SearchBarItem.h"

@interface SearchViewController () <UXCollectionViewDataSource, UXCollectionViewDelegate>

@property (nonatomic, strong) UXLabel *emptyLabel;
@property (nonatomic, strong) SearchBarItem *searchItem;
@property (nonatomic, strong) CollectionViewDataHandler *dataHandler;

@end

@implementation SearchViewController

+ (PhotosFlowLayout *)defaultLayout
{
    PhotosFlowLayout *flowLayout = [[PhotosFlowLayout alloc] init];
    flowLayout.itemSize = NSMakeSize(50, 50);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = NSEdgeInsetsMake(5, 5, 5, 5);
    
    return flowLayout;
}

- (id)init
{
    return [self initWithCollectionViewLayout:[SearchViewController defaultLayout]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataHandler = [[CollectionViewDataHandler alloc] initWithReceptor:(id<CollectionViewDataHandlerReceptor>)self.collectionView];
    
    self.collectionView.allowsSelection = YES;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photo"];
    
    [self addObserver:self forKeyPath:@"photos" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:NULL];
    
    self.searchItem = [[SearchBarItem alloc] init];
    self.searchItem.width = 200;
    self.navigationItem.rightBarButtonItem = self.searchItem;
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    
    self.view.window.identifier = @"main";
}

- (void)showEmptyScreen
{
    if (!self.emptyLabel) {
        self.emptyLabel = [UXLabel new];
        self.emptyLabel.text = @"No pictures yet.\n\nFind some cool pictures using the search field above.";
        self.emptyLabel.numberOfLines = 0;
        self.emptyLabel.textAlignment = NSCenterTextAlignment;
        self.emptyLabel.font = [NSFont systemFontOfSize:13.0 weight:NSFontWeightMedium];
        self.emptyLabel.textColor = [NSColor colorWithCalibratedWhite:0.6 alpha:1.0];
        self.emptyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.emptyLabel sizeToFit];
        
        [self.view addSubview:self.emptyLabel];
        
        [self.emptyLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
        [self.emptyLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        self.emptyLabel.alphaValue = 0;
    }
    
    self.emptyLabel.animator.alphaValue = 1;
}

- (void)hideEmptyScreen
{
    self.emptyLabel.animator.alphaValue = 0;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"photos"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"photos"]) {
        if (!self.photos.count) {
            [self showEmptyScreen];
        } else {
            [self hideEmptyScreen];
        }
        self.dataHandler.photos = self.photos;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (NSMutableArray<Photo *> *)photos
{
    if (!_photos) _photos = [NSMutableArray new];
    
    return _photos;
}

- (NSInteger)numberOfSectionsInCollectionView:(UXCollectionView *)collectionView
{
    return 1;
}

- (long long)collectionView:(UXCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UXCollectionViewCell *)collectionView:(UXCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    cell.photo = self.photos[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UXCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoViewController *photoVC = [[PhotoViewController alloc] initWithPhoto:self.photos[indexPath.item]];
    [self.navigationController pushViewController:photoVC animated:YES];
}

@end
