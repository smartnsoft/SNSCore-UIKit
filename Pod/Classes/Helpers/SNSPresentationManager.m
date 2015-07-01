//
//  SNSPresentationManager.m
//  Pods
//
//  Created by Florian Basso on 01/07/2015.
//
//

#import "SNSPresentationManager.h"


@implementation SNSPresentationManager  

#pragma mark - Lazy Instantiation
- (SNSTransitionType)transitionTypeDismiss
{
    if (!_transitionTypeDismiss)
    {
        _transitionTypeDismiss = SNSTransitionTypeLeftToRight;
    }
    return _transitionTypeDismiss;
}

- (SNSTransitionType)transitionTypeShow
{
    if (!_transitionTypeShow)
    {
        _transitionTypeShow = SNSTransitionTypeRightToLeft;
    }
    return _transitionTypeShow;
}

#pragma mark - Singleton
+ (instancetype)sharedInstance
{
    static SNSPresentationManager *sharedPresentationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPresentationManager = [[self alloc] init];
    });
    return sharedPresentationManager;
}

#pragma mark - UIViewControllerTransitioningDelegate -
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    [SNSTransitionManager sharedInstance].transitionType = self.transitionTypeShow;
    return [SNSTransitionManager sharedInstance];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    [SNSTransitionManager sharedInstance].transitionType = self.transitionTypeDismiss;
    return [SNSTransitionManager sharedInstance];
}

@end



