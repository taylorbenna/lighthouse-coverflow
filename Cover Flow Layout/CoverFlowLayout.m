//
//  CoverFlowLayout.m
//  Cover Flow Layout
//
//  Created by Taylor Benna on 2016-05-19.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "CoverFlowLayout.h"

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees)/180)

@implementation CoverFlowLayout

-(void)prepareLayout {
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(300, 300);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRegion;
    visibleRegion.origin = self.collectionView.contentOffset;
    visibleRegion.size   = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        
        CGFloat temp = attr.center.x - (visibleRegion.origin.x + (visibleRegion.size.width/2));
        CGFloat scale = 1 - (fabs(temp / visibleRegion.size.width));
        CGFloat rotate = (temp / visibleRegion.size.width);

        
        attr.alpha = scale;
        
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DMakeScale(scale, scale, scale);
        transform.m34 = 1.0 / -500;
        transform = CATransform3DRotate(transform, rotate, 0, 1, 0.0f);
        attr.transform3D = transform;
        
        
    }
    
    return attributes;

}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
