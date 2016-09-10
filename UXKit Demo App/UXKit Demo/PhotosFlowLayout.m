//
//  PhotosFlowLayout.m
//  UXKit Demo
//
//  Created by Guilherme Rambo on 10/09/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "PhotosFlowLayout.h"

@implementation PhotosFlowLayout

- (UXCollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)indexPath
{
    UXCollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
    
    attrs.alpha = 0;
    
    return attrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(NSRect)newBounds
{
    return YES;
}

@end
