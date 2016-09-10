//
//  AppDelegate.h
//  UXKit Demo
//
//  Created by Guilherme Rambo on 09/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (IBAction)search:(id)sender;
- (void)showLoadingStatus;
- (void)hideLoadingStatus;

@end

