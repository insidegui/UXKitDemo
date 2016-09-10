//
//  AppDelegate.m
//  UXKit Demo
//
//  Created by Guilherme Rambo on 09/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "AppDelegate.h"

#import "UXKit.h"

#import "SearchViewController.h"

#import "Credentials.h"

@import FlickrSearch;

@interface AppDelegate ()

@property (nonatomic, strong) FlickrFetcher *fetcher;

@property (nonatomic, strong) NSProgressIndicator *progressIndicator;
@property (nonatomic, strong) SearchViewController *searchViewController;
@property (nonatomic, strong) UXWindowController *mainWindowController;
@property (nonatomic, strong) UXNavigationController *navController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.fetcher = [[FlickrFetcher alloc] initWithCredentials:[[FlickrCredentials alloc] initWithKey:kFlickrApiKey secret:kFlickrApiSecret]];
    
    self.searchViewController = [[SearchViewController alloc] init];
    
    self.navController = [[UXNavigationController alloc] initWithRootViewController:self.searchViewController];
    
    self.mainWindowController = [[UXWindowController alloc] initWithRootViewController:self.navController];
    [self.mainWindowController showWindow:self];
}

- (IBAction)search:(id)sender {
    NSString *searchString = @"Beautiful Landscape";
    if ([sender respondsToSelector:@selector(stringValue)]) searchString = [sender stringValue];
    
    if (searchString.length < 3) return;
    
    [self showLoadingStatus];
    
    [self.fetcher searchFor:searchString completionHandler:^(NSArray<Photo *> *photos, NSError *error) {
        [self hideLoadingStatus];
        
        if (error) {
            NSLog(@"Search error: %@", error);
        } else {
            self.searchViewController.photos = [[photos arrayByAddingObjectsFromArray:self.searchViewController.photos] mutableCopy];
        }
    }];
}

- (void)showLoadingStatus
{
    if (!self.progressIndicator) {
        self.progressIndicator = [[NSProgressIndicator alloc] init];
        self.progressIndicator.wantsLayer = YES;
        self.progressIndicator.indeterminate = YES;
        self.progressIndicator.displayedWhenStopped = NO;
        self.progressIndicator.style = NSProgressIndicatorSpinningStyle;
        self.progressIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        [self.progressIndicator.widthAnchor constraintEqualToConstant:22.0].active = YES;
        [self.progressIndicator.heightAnchor constraintEqualToConstant:22.0].active = YES;
        [self.mainWindowController.window.contentView addSubview:self.progressIndicator];
        [self.progressIndicator.centerYAnchor constraintEqualToAnchor:self.mainWindowController.window.contentView.centerYAnchor].active = YES;
        [self.progressIndicator.centerXAnchor constraintEqualToAnchor:self.mainWindowController.window.contentView.centerXAnchor].active = YES;
        self.progressIndicator.layer.zPosition = 99;
    }
    
    [self.progressIndicator startAnimating];
}

- (void)hideLoadingStatus
{
    [self.progressIndicator stopAnimating];
}


@end
