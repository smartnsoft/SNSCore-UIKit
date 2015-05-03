//
//  UIView+SNSCoreKit.m
//  Pods
//
//  Created by Roaflin on 3/5/15.
//
//

#import "UIView+SNSCoreUIKit.h"

@implementation UIView (SNSCoreUIKit)

#pragma mark - Recursively methods

- (UIView*)rootview
{
    if (self.superview == nil)
        return self;
    
    return [self.superview rootview];
}

- (UIView *)superviewOfClass:(Class)iclass
{
    if ([self isKindOfClass:iclass])
        return self;
    
    if (self.superview == nil)
        return nil;
    
    return [self.superview superviewOfClass:iclass];
}

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

- (void)applyBlockRecursively:(void (^)(id))block stop:(BOOL *)stop
{
    if (stop != NULL && *stop == YES)
        return;
    
    block(self);
    
    for (UIView* view in self.subviews)
        [view applyBlockRecursively:block stop:stop];
}

#pragma mark - Animations

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

-(void)fadeFromInitialAlpha:(CGFloat)initialAlpha finalAlpha:(CGFloat)finalAlpha andDuration:(NSTimeInterval)duration
{
    [self setAlpha:initialAlpha];
    
    [UIView animateWithDuration:duration animations:^{
        [self setAlpha:finalAlpha];
    }];
}

#pragma mark - Customs shape view

- (void) cutSide:(CutterViewSideType)sideToCut
{
    CGRect bounds = self.bounds;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    CGPoint points[3];
    
    switch (sideToCut)
    {
        case CutterViewSideTypeLeft:
            points[0] = CGPointZero;
            points[1] = CGPointMake(50, 0);
            points[2] = CGPointMake(0, self.frame.size.height);
            break;
        case CutterViewSideTypeRight:
            points[0] = CGPointMake(self.frame.size.width, 0);
            points[1] = CGPointMake(self.frame.size.width, self.frame.size.height);
            points[2] = CGPointMake(self.frame.size.width - 50, self.frame.size.height);
            break;
        default:
            break;
    }
    
    CGMutablePathRef cgPath = CGPathCreateMutable();
    CGPathAddLines(cgPath, &CGAffineTransformIdentity, points, sizeof points / sizeof *points);
    CGPathCloseSubpath(cgPath);
    
    UIBezierPath *path =  [UIBezierPath bezierPathWithCGPath:cgPath];
    [path appendPath:[UIBezierPath bezierPathWithRect:bounds]];
    maskLayer.path = path.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    
    self.layer.mask = maskLayer;
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size
{
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    
    CAShapeLayer* maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

- (void)addInContainerView:(UIView*)containerView edgeInsets:(UIEdgeInsets)edgeInsets
{
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:containerView];
    
    
    NSString *hConstraint = [NSString stringWithFormat:@"H:|-%f-[containerView]-%f-|", edgeInsets.left, edgeInsets.right];
    NSString *vConstraint = [NSString stringWithFormat:@"V:|-%f-[containerView]-%f-|", edgeInsets.top, edgeInsets.bottom];
    
    [self addConstraints:ConstraintsWithVisualFormatAndViews(hConstraint, containerView)];
    [self addConstraints:ConstraintsWithVisualFormatAndViews(vConstraint, containerView)];
}



@end
