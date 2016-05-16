//
//  SNSTransitionManager.m
//  Pods
//
//  Created by Florian Basso on 01/07/2015.
//
//

#import "SNSTransitionManager.h"
#import "UIView+SNSCoreUIKit.h"


const CGFloat kMargin = 20.0f;
const CGFloat kZTranslate = 100.0f; // Magic number to get the layer 'closer' in a 3D sense, before rotation so that it doesn't disappear under the background
const CGFloat kRotation = 20.0f;
const CGFloat kRotationIpad = 5.0f;
const CGFloat kM34Perspective = 1.0 / -500; // Magic number to have a 3D perspective effect
const CGFloat kWidthRatio = 1.5;
const CGFloat kWidthRatioIpad = 3.0;

@interface SNSTransitionManager()
@property (strong, nonatomic) UIViewController *currentAirController;
@end

@implementation SNSTransitionManager

#pragma mark - Singleton
+ (instancetype)sharedInstance
{
    static SNSTransitionManager *sharedTransitionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTransitionManager = [[self alloc] init];
    });
    return sharedTransitionManager;
}


#pragma mark - Transition Management
//Define the transition duration
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}


//Define the transition
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = [transitionContext containerView];
    
    // Set background view if Needed
    [self insertBackgroundViewInContainer:container];
    
    /*   Draw different transitions depending on the view to show
     for sake of clarity this code is divided in different blocks
     */
    
    switch (self.transitionType)
    {
        case SNSTransitionTypeRightToLeft:
        {
            [self rightToLeftAnimationWithContext:transitionContext];
            break;
        }
        case SNSTransitionTypeLeftToRight:
        {
            [self leftToRightAnimationWithContext:transitionContext];
            break;
        }
        case SNSTransitionTypeAirShow:
        {
            [self airShowAnimationWithContext:transitionContext];
            break;
        }
        case SNSTransitionTypeAirDimiss:
        {
            [self airDismissAnimationWithContext:transitionContext];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Animations Methods
- (void) rightToLeftAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];
    
    [toVC.view setFrame:CGRectMake(sourceRect.size.width, 0, sourceRect.size.width, sourceRect.size.height)];
    
    [container insertSubview:toVC.view aboveSubview:fromVC.view];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:.8
          initialSpringVelocity:6.0
                        options:UIViewAnimationOptionCurveEaseIn
     
                     animations:^{
                         
                         [toVC.view setTransform:CGAffineTransformMakeTranslation(-toVC.view.frame.size.width, 0)];
                         
                     } completion:^(BOOL finished) {
                         
                         //When the animation is completed call completeTransition
                         [transitionContext completeTransition:YES];
                     }];
}

- (void) leftToRightAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:1
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseIn
     
                     animations:^{
                         
                         // Move the view off the screen
                         [fromVC.view setTransform:CGAffineTransformMakeTranslation(fromVC.view.frame.size.width, 0)];
                         
                     } completion:^(BOOL finished) {
                         //When the animation is completed call completeTransition
                         [transitionContext completeTransition:YES];
                     }];
}

- (void) airShowAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];
    
    [container insertSubview:toVC.view aboveSubview:fromVC.view];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:.8
          initialSpringVelocity:6.0
                        options:UIViewAnimationOptionCurveEaseIn
     
                     animations:^{
                         
                         CALayer *layer = fromVC.view.layer;
                         CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                         rotationAndPerspectiveTransform.m34 = kM34Perspective;
                         rotationAndPerspectiveTransform = CATransform3DScale(rotationAndPerspectiveTransform, 0.5, 0.5, 1.0);
                         
                         if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad)
                         {
                             [toVC.view setFrame:CGRectMake(sourceRect.size.width - sourceRect.size.width/kWidthRatioIpad, 0, sourceRect.size.width/kWidthRatioIpad, sourceRect.size.height)];
                             rotationAndPerspectiveTransform = CATransform3DTranslate(rotationAndPerspectiveTransform, -sourceRect.size.width/kWidthRatioIpad + kMargin, 0, kZTranslate*2);
                             rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, kRotationIpad * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
                         }
                         else
                         {
                             [toVC.view setFrame:CGRectMake(sourceRect.size.width - sourceRect.size.width/kWidthRatio, 0, sourceRect.size.width/kWidthRatio, sourceRect.size.height)];
                             rotationAndPerspectiveTransform = CATransform3DTranslate(rotationAndPerspectiveTransform, -sourceRect.size.width + kMargin, 0, kZTranslate);
                             rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, kRotation * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
                         }
                         
                         layer.transform = rotationAndPerspectiveTransform;
                         
                     } completion:^(BOOL finished) {
                         
                         //When the animation is completed call completeTransition
                         
                         UIView *dismissView;
                         
                         if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad)
                         {
                             dismissView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sourceRect.size.width - sourceRect.size.width/kWidthRatioIpad, sourceRect.size.height)];
                         }
                         else
                         {
                             dismissView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sourceRect.size.width - sourceRect.size.width/kWidthRatio, sourceRect.size.height)];
                         }
                         
                         
                         UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAirController)];
                         [dismissView addGestureRecognizer:tapGestureRecognizer];
                         [container addSubview:dismissView];
                         self.currentAirController = toVC;
                         
                         [transitionContext completeTransition:YES];
                     }];
}


- (void) airDismissAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:.8
          initialSpringVelocity:6.0
                        options:UIViewAnimationOptionCurveEaseIn
     
                     animations:^{
                         
                         CATransform3D resetTransform = CATransform3DIdentity;
                         toVC.view.layer.transform = resetTransform;
                         [fromVC.view setTransform:CGAffineTransformMakeTranslation(fromVC.view.frame.size.width, 0)];
                         [self.backgroundView fadeFromInitialAlpha:self.backgroundView.alpha finalAlpha:0.0 andDuration:0.2];
                         
                     } completion:^(BOOL finished) {
                         
                         //When the animation is completed call completeTransition
                         [transitionContext completeTransition:YES];
                     }];

}

#pragma mark - Views Management
- (void) insertBackgroundViewInContainer:(UIView*)container
{
    if (self.useBackgroundView)
    {
        if (self.backgroundView)
        {
            [container insertSubview:self.backgroundView atIndex:0];
        }
        else
        {
            UIView *defaultBlackView = [[UIView alloc] initWithFrame:container.bounds];
            [defaultBlackView setBackgroundColor:[UIColor blackColor]];
            defaultBlackView.alpha = 0.5;
            [container insertSubview:defaultBlackView atIndex:0];
        }
    }
}

- (void) dismissAirController
{
    [self.currentAirController dismissViewControllerAnimated:YES completion:nil];
}
@end
