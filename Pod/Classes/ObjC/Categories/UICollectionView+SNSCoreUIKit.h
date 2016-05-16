//
//  UICollectionView+SNSCoreUIKit.h
//  Pods
//
//  Created by Jean-Charles SORIN on 07/07/2015.
//
//

#import <UIKit/UIKit.h>

@interface UICollectionView (SNSCoreUIKit)

/**
 Return the index path at the "center" of the collection view.
 Typically usefull when you have a UICollectionView with paging enabled and you want to know the index path at the center of your collectionview/screen.
 */
- (NSIndexPath*)currentIndexPathInCenter;

@end
