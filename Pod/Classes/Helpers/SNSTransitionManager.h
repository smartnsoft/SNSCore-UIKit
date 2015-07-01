//
//  SNSTransitionManager.h
//  Pods
//
//  Created by Florian Basso on 01/07/2015.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SNSTransitionType){
    SNSTransitionTypeLeftToRight = 0,
    SNSTransitionTypeRightToLeft,
    SNSTransitionTypeAirDimiss,
    SNSTransitionTypeAirShow
};

@interface SNSTransitionManager : NSObject <UIViewControllerAnimatedTransitioning>


#pragma mark - Properties
@property (nonatomic, assign) SNSTransitionType transitionType;
@property (nonatomic, assign) NSTimeInterval transitionDuration;

@property (weak, nonatomic) UIView *backgroundView;
@property (nonatomic) BOOL useBackgroundView;


#pragma mark - Methods
+ (instancetype)sharedInstance;

#pragma mark - Animations Methods
- (void) rightToLeftAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void) leftToRightAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void) airShowAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void) airDismissAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
