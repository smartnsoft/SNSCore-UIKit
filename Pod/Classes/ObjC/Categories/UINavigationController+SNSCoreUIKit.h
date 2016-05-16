//
//  UINavigationController+SNSCoreUIKit.h
//  Pods
//
//  Created by Roaflin on 3/5/15.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SNSCoreUIKit)

/**
 *  Display a controller as the rootViewController
 *
 *  @param viewController The viewController that must be displayed as rootViewController
 */
- (void) popAndPushViewController:(UIViewController *)viewController;

/**
 *  Pop a few controllers
 *
 *  @param howMany  The number of controllers to be removed
 *  @param animated A boolean indicated if the removal must be animated
 */
- (void) popViewControllers:(NSUInteger)howMany animated:(BOOL)animated;

@end
