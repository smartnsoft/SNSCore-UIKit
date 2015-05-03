//
//  UIView+SNSCoreKit.h
//  Pods
//
//  Created by Roaflin on 3/5/15.
//
//

#import <UIKit/UIKit.h>

@interface UIView (SNSCoreUIKit)

- (void)localizeRecursively;
- (NSArray*)subviewsOfClass:(Class)iClass;
- (void)applyBlockRecursively:(void (^)(id))block stop:(BOOL*)stop;

- (UIView*)rootview;
- (UIView*)superviewOfClass:(Class)iClass;

#pragma mark Animations
- (void)animateWithBounceEffect;

@end
