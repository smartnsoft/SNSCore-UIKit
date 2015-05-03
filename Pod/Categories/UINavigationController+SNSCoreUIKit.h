//
//  UINavigationController+SNSCoreUIKit.h
//  Pods
//
//  Created by Roaflin on 3/5/15.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SNSCoreUIKit)

- (void) popAndPushViewController:(UIViewController *)viewController;
- (void) popViewControllers:(NSUInteger)howMany animated:(BOOL)animated;

@end
