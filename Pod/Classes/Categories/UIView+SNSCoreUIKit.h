//
//  UIView+SNSCoreKit.h
//  Pods
//
//  Created by Roaflin on 3/5/15.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CutterViewSideType)
{
    CutterViewSideTypeRight,
    CutterViewSideTypeLeft
};


@interface UIView (SNSCoreUIKit)

- (void)localizeRecursively;
- (NSArray*)subviewsOfClass:(Class)iClass;
- (void)applyBlockRecursively:(void (^)(id))block stop:(BOOL*)stop;
- (UIView*)rootview;
- (UIView*)superviewOfClass:(Class)iClass;

- (void)animateWithBounceEffect;
-(void)fadeFromInitialAlpha:(CGFloat)initialAlpha finalAlpha:(CGFloat)finalAlpha andDuration:(NSTimeInterval)duration;

- (void)cutSide:(CutterViewSideType)sideToCut;
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size;

@end
