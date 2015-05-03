//
//  UIViewController+SNCoreUIKit.m
//  Pods
//
//  Created by Jean-Charles SORIN on 03/05/2015.
//
//

#import "UIViewController+SNCoreUIKit.h"

#import "UIView+SNSCoreUIKit.h"

@implementation UIViewController (SNCoreUIKit)

-(void)addInContainer:(UIView*)container childViewController:(UIViewController*)viewController
{
    [self addInContainer:container childViewController:viewController edgeInsets:UIEdgeInsetsZero];
}

-(void)addInContainer:(UIView*)container childViewController:(UIViewController*)viewController edgeInsets:(UIEdgeInsets)edgeInsets
{
    if(!container || !viewController)
    {
        NSString *msg = [NSString stringWithFormat:@"Container views (%@) or/and child view controllers (%@) must not be nil",container,viewController];
#ifdef DEBUG
        NSLog(@"UIViewController+SNCoreUIKit/addInContainer - %@", msg);
#endif
    }
    else
    {
        UIView* childView = viewController.view;
        
        [self addChildViewController:viewController];
        [container addInContainerView:childView edgeInsets:edgeInsets];
        [viewController didMoveToParentViewController:self];
        
    }
}

-(void)switchFromViewController:(UIViewController*) fromViewController
               toViewController:(UIViewController*) toViewController
                    inContainer:(UIView*) container
                       animated:(BOOL) animated
                     completion:(void (^)(BOOL finished))completion
{
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    UIView *childView = toViewController.view;
    [container addInContainerView:childView edgeInsets:UIEdgeInsetsZero];
    
    CGFloat animationDuration = animated ? 0.35 : 0;
    
    if(fromViewController)
    {
        [self transitionFromViewController:fromViewController
                          toViewController:toViewController
                                  duration:animationDuration
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:nil
                                completion:^(BOOL finished)
         {
             [fromViewController removeFromParentViewController];
             [toViewController didMoveToParentViewController:self];
             
             if (completion) completion(finished);
         }];
    }
    else
    {
        toViewController.view.alpha = 0;
        
        [UIView animateWithDuration:animationDuration animations:^{
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            [toViewController didMoveToParentViewController:self];
            
            if (completion) completion(finished);
        }];
    }
}


@end
