//
//  UICollectionView+SNSCoreUIKit.m
//  Pods
//
//  Created by Jean-Charles SORIN on 07/07/2015.
//
//

#import "UICollectionView+SNSCoreUIKit.h"

@implementation UICollectionView (SNSCoreUIKit)

- (NSIndexPath *)currentIndexPathInCenter
{
    CGPoint centerPoint = CGPointMake(self.frame.size.width / 2 + self.contentOffset.x,
                                      self.frame.size.height /2 + self.contentOffset.y);
    NSIndexPath *currentIndexPath = [self indexPathForItemAtPoint:centerPoint];
    
    return currentIndexPath;
}

@end
