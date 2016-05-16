//
//  UIView+SNSCoreKit.h
//  Pods
//
//  Created by Roaflin on 3/5/15.
//
//

#import <UIKit/UIKit.h>

#define ConstraintsWithVisualFormatAndViews(Format, ...) ([NSLayoutConstraint constraintsWithVisualFormat:Format options:0 metrics:nil views:NSDictionaryOfVariableBindings(__VA_ARGS__)])

typedef NS_ENUM(NSUInteger, CutterViewSideType)
{
    CutterViewSideTypeRight,
    CutterViewSideTypeLeft,
    CutterViewSideTypeTop,
    CutterViewSideTypeBottom
};


@interface UIView (SNSCoreUIKit)

/**
 * Commodity accessor for `frame.origin.x`
 *
 * Sets frame.origin.x = roundf(left)
 */
@property(nonatomic) CGFloat left;

/**
 * Commodity accessor for `frame.origin.y`
 *
 * Sets frame.origin.y = roundf(top)
 */
@property(nonatomic) CGFloat top;

/**
 * Commodity accessor for `frame.origin.x + frame.size.width`
 *
 * Sets frame.origin.x = roundf(right - frame.size.width)
 */
@property(nonatomic) CGFloat right;

/**
 * Commodity accessor for `frame.origin.y + frame.size.height`
 *
 * Sets frame.origin.y = roundf(bottom - frame.size.height)
 */
@property(nonatomic) CGFloat bottom;

/**
 * Commodity accessor for `frame.size.width`
 *
 * Sets frame.size.width = roundf(width)
 * @warning If your view's transform is not identity, you should use boundsWidth
 */
@property(nonatomic) CGFloat width;

/**
 * Commodity accessor for `frame.size.height`
 *
 * Sets frame.size.height = roundf(height)
 * @warning If your view's transform is not identity, you should use boundsHeight
 */
@property(nonatomic) CGFloat height;

/**
 * Commodity accessor for `center.x`
 *
 * Sets center.x = roundf(centerX)
 */
@property(nonatomic) CGFloat centerX;

/**
 * Commodity accessor for `center.y`
 *
 * Sets center.y = roundf(centerY)
 */
@property(nonatomic) CGFloat centerY;

/**
 * Commodity accessor for `frame.size`
 */
@property(nonatomic) CGSize size;

/**
 * @abstract
 *  Recursively checks all superview of caller view until nil is found.
 *  The last non nil view is then returned
 */
- (UIView*)rootview;

/**
 * @abstract
 *  Recursively checks all superview of caller view until iclass is found.
 *  If the class is not found, nil is returned instead
 */
- (UIView*)superviewOfClass:(Class)iClass;

/**
 * @abstract
 *  Goes through all the subviews and will automatically call NSLocalizedString with the text set.
 * @discussion
 *  This is very useful when using XIB files because you only have to put the keys inside labels/buttons...
 *  and one call to this selector on the main will localize everything.
 */
- (void)localizeRecursively;

/**
 * @warning
 *  This method is recursive and will add all subviews, subviews objects the class
 *  passed in parameter
 */
- (NSArray*)subviewsOfClass:(Class)iClass;

/**
 * @abstract
 *  Apply a given block recursively to all subviews
 */
- (void)applyBlockRecursively:(void (^)(id))block stop:(BOOL*)stop;


// TODO: Check if this method is still useful
- (void)animateWithBounceEffect;

/**
 *  This method allows to fade in / fade out a UIView smoothly
 *
 *  @param initialAlpha The initial alpha before the animation starts
 *  @param finalAlpha   The final alpha when the animations finishes
 *  @param duration     The animation duration in seconds
 */
-(void)fadeFromInitialAlpha:(CGFloat)initialAlpha finalAlpha:(CGFloat)finalAlpha andDuration:(NSTimeInterval)duration;


/**
 *  Cut the side of the view
 *
 *  @param diagonalWidth The distance that will be cut
 */
- (void) cutSide:(CutterViewSideType)sideToCut withDiagonal:(CGFloat)diagonalWidth;

/**
 *  Add Rounded Corners to a UIView
 *
 *  @param corners The corners in which to apply changes
 *  @param size    The size of the radius
 */
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size;

/**
 Add the current UIView inside another. You can specify edgeInsets to set up margin between the parent and the child view
 @param subview The parent view which embed your view
 @param edgeInsets UIEdgeInsets for the child view according to the parent
 */
- (void)addFillView:(UIView*)view withInsets:(UIEdgeInsets)edgeInsets;


/**
 *  Show or hide all subviews of a view
 *
 *  @param mustShow Defines if the method must show or hide all subviews
 */
- (void) showOrHideViewsRecursively:(BOOL)mustShow;

@end
