//
//  UIView+SNSCoreKit.m
//  Pods
//
//  Created by Roaflin on 3/5/15.
//
//

#import "UIView+SNSCoreKit.h"

@implementation UIView (SNSCoreKit)

/**
 * @abstract
 *  Recursively checks all superview of caller view until nil is found.
 *  The last non nil view is then returned
 */
- (UIView*)rootview
{
    if (self.superview == nil)
        return self;
    
    return [self.superview rootview];
}

/**
 * @abstract
 *  Recursively checks all superview of caller view until iclass is found.
 *  If the class is not found, nil is returned instead
 */
- (UIView *)superviewOfClass:(Class)iclass
{
    if ([self isKindOfClass:iclass])
        return self;
    
    if (self.superview == nil)
        return nil;
    
    return [self.superview superviewOfClass:iclass];
}

/**
 * @abstract
 *  Goes through all the subviews and will automatically call NSLocalizedString with the text set.
 * @discussion
 *  This is very useful when using XIB files because you only have to put the keys inside labels/buttons...
 *  and one call to this selector on the main will localize everything.
 */
- (void)localizeRecursively
{
    for (UIView* v in [self subviews])
    {
        if ([v isKindOfClass:[UILabel class]])
            [(UILabel*)v setText:NSLocalizedString([(UILabel*)v text], nil)];
        
        else if ([v isKindOfClass:[UIButton class]])
        {
            [(UIButton*)v setTitle:NSLocalizedString([(UIButton*)v titleForState:UIControlStateNormal], nil)
                          forState:UIControlStateNormal];
        }
        
        else if ([v isKindOfClass:[UITextField class]])
        {
            
            UITextField* f = (UITextField*)v;
            f.text = NSLocalizedString(f.text, nil);
            f.placeholder = NSLocalizedString(f.placeholder, nil);
        }
        
        [v localizeRecursively];
    }
}

/**
 * @warning
 *  This method is recursive and will add all subviews, subviews objects the class
 *  passed in parameter
 */
- (NSArray *)subviewsOfClass:(Class)iClass
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:self.subviews.count];
    
    for (UIView* v in self.subviews)
    {
        if ([v isKindOfClass:iClass])
            [array addObject:v];
        
        // recursively add objects from subviews of self
        [array addObjectsFromArray:[v subviewsOfClass:iClass]];
    }
    
    return [NSArray arrayWithArray:array];
}

/**
 * @abstract
 *  Apply a given block recursively to all subviews
 */
- (void)applyBlockRecursively:(void (^)(id))block stop:(BOOL *)stop
{
    if (stop != NULL && *stop == YES)
        return;
    
    block(self);
    
    for (UIView* view in self.subviews)
        [view applyBlockRecursively:block stop:stop];
}

#pragma mark - Animations
// TODO: Check if this method is still useful
- (void)animateWithBounceEffect
{
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{self.alpha = 1.0;}];
    
    self.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.5],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.8],
                              [NSNumber numberWithFloat:1.0], nil];
    bounceAnimation.duration = 0.4;
    bounceAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
    self.layer.transform = CATransform3DIdentity;
}

/**
 *  This method allows to fade in / fade out a UIView smoothly
 *
 *  @param initialAlpha The initial alpha before the animation starts
 *  @param finalAlpha   The final alpha when the animations finishes
 *  @param duration     The animation duration in seconds 
 */
-(void)fadeFromInitialAlpha:(CGFloat)initialAlpha finalAlpha:(CGFloat)finalAlpha andDuration:(NSTimeInterval)duration
{
    [self setAlpha:initialAlpha];
    
    [UIView animateWithDuration:duration animations:^{
        [self setAlpha:finalAlpha];
    }];
}

@end
