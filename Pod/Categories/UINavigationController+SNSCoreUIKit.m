//
//  UINavigationController+SNSCoreUIKit.m
//  Pods
//
//  Created by Roaflin on 3/5/15.
//
//

#import "UINavigationController+SNSCoreUIKit.h"

@implementation UINavigationController (SNSCoreUIKit)

/**
 *  Display a controller as the rootViewController
 *
 *  @param viewController The viewController that must be displayed as rootViewController
 */
- (void) popAndPushViewController:(UIViewController *)viewController
{
    if ([self.viewControllers count] > 1)
    {
        [self popViewControllerAnimated:NO];
        [self pushViewController:viewController animated:NO];
    }
    else
    {
        [self setViewControllers:[NSArray arrayWithObjects:viewController,nil] animated:NO];
    }
}

/**
 *  Pop a few controllers
 *
 *  @param howMany  The number of controllers to be removed
 *  @param animated A boolean indicated if the removal must be animated
 */
- (void) popViewControllers:(NSUInteger)howMany animated:(BOOL)animated
{
    NSRange range;
    range.location = 0;
    range.length = [self.viewControllers count] - howMany;
    // Caution: do not use the animation, otherwise the UINavigationControler gets lost!
    [self setViewControllers:[self.viewControllers subarrayWithRange:range] animated:animated];
}

@end
