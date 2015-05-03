//
//  UIViewController+SNCoreUIKit.h
//  Pods
//
//  Created by Jean-Charles SORIN on 03/05/2015.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (SNCoreUIKit)

/**
 UIViewController containment : add a UIViewController child inside your current UIViewController.
 Specify the UIView which be contain your UIViewController child
 @param container The UIView container of the UIViewController to add
 @param viewController The UIViewController which will be added inside the UIView container
 */
-(void)addInContainer:(UIView*)container childViewController:(UIViewController*)viewController;

/**
 UIViewController containment : switch between two child view controllers.
 Note : be sure that your previously add the fromViewController before. UIKit can't make a transition to a fromviewController which is be not in your stack or container
 @param fromViewController The initial UIViewController which will be replaced
 @param toViewController The new UIViewController which will be added instead of the fromViewController
 @param container The UIVIew Container for the viewControllers
 @param animated Specify if you want to animate the transition with a cross fading whith a default duration of 0.35
 @param completion After the switching transition completed, execute some code
 */
-(void)switchFromViewController:(UIViewController*) fromViewController
               toViewController:(UIViewController*) toViewController
                    inContainer:(UIView*) container
                       animated:(BOOL) animated
                     completion:(void (^)(BOOL finished))completion;

@end
