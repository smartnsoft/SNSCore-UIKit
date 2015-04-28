//
//  SNSDropListView.m
//  Pods
//
//  Created by Florian Basso on 10/04/2015.
//
//

#import "SNSDropListView.h"


#pragma mark - Constants

static CGFloat const kSnSDropListLabelDefaulttHeight = 30.f;



@implementation SNSDropListView

#pragma mark - Lazy Instantiation
- (UIView *)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _backgroundView.backgroundColor = [UIColor clearColor];
    }
    return _backgroundView;
}

- (UILabel *)mainLabel
{
    if (!_mainLabel)
    {
        _mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height)];
        _mainLabel.backgroundColor = [UIColor clearColor];
    }
    return _mainLabel;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.userInteractionEnabled = YES;
    }
    return _scrollView;
}

- (UIImageView *)backgroundImage
{
    if (!_backgroundImage)
    {
        _backgroundImage = [[UIImageView alloc] initWithFrame:(CGRect){0, 0, self.frame.size}];
        _backgroundImage.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _backgroundImage;
}

- (UIImageView *)arrowImage
{
    if (!_arrowImage)
    {
        _arrowImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _arrowImage.contentMode = UIViewContentModeCenter;
        _arrowImage.frame = CGRectMake(self.frame.size.width - 30, 0, 30, self.frame.size.height);
        _arrowImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    }
    return _arrowImage;
}

- (CGFloat)maxScrollHeight
{
    if (_maxScrollHeight)
    {
        _maxScrollHeight = 120.f;
    }
    return _maxScrollHeight;
}

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
        [self setup];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
        [self setup];
    
    return self;
}


- (void)setup
{
    // -----------------------------
    //
    // -----------------------------
    self.clipsToBounds = NO;
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4.f;
    self.enabled = YES;
    
    // -----------------------------
    // Configure Sub Views
    // -----------------------------
    [self.backgroundView addSubview:self.backgroundImage];
    [self.backgroundView addSubview:self.arrowImage];
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.mainLabel];
    
    // -----------------------------
    // Configure Gesture Recognizer
    // -----------------------------
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapMainView:)];
    tap.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tap];
}

- (void) setFrame:(CGRect)iFrame
{
    [super setFrame:iFrame];
    
    self.mainLabel.frame = CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height);
    self.backgroundView.frame   = (CGRect){CGPointZero, self.bounds.size};
    self.scrollView.frame       = CGRectMake(0, self.frame.size.height, self.frame.size.width, 0);
    self.backgroundImage.frame    = (CGRect){0, 0, self.frame.size};
    self.arrowImage.frame         = CGRectMake(self.frame.size.width - 30, 0, 30, self.frame.size.height);
}

- (void)dealloc
{
    self.delegate = nil;
    self.dataSource = nil;
    self.mainLabelColor = nil;
    self.scrollViewColorBorder = nil;
    self.labelCellDefaultColor = nil;
    self.labelCellSelectedColor = nil;
    self.labelCellBackgroundSelectedColor = nil;
    self.mainLabelFont = nil;
    self.labelCellFont = nil;
    self.scrollView = nil;
}

#pragma mark -
#pragma mark Events
#pragma mark -

- (void)onTapMainView:(id)sender
{
    BOOL shouldTap = YES;
    
    if ([self.delegate respondsToSelector:@selector(dropList:shouldReceiveTap:)]) {
        shouldTap = [self.delegate dropList:self shouldReceiveTap:[self.gestureRecognizers firstObject]];
    }
    
    if (!self.enabled || !shouldTap)
        return;
    
    if ([self.delegate respondsToSelector:@selector(didTapDropListView:)])
        [self.delegate didTapDropListView:self];
    
    if (SnSViewH(self.scrollView) == 0)
        [self openScrollView];
    else
        [self closeScrollView];
}

- (void)onTapCellView:(id)sender
{
    SNSDropListViewCell* cell = (SNSDropListViewCell*)[sender view];
    
    // set previous seletected cell to unselected
    [self.selectedCell setSelected:NO animated:YES];
    
    // update current selected cell
    if ([cell isKindOfClass:[SNSDropListViewCell class]])
    {
        self.selectedCell = cell;
        [self.selectedCell setSelected:YES animated:YES];
    }
    
    // update main label (default behaviour)
    self.mainLabel.textColor = [UIColor blackColor];
    self.mainLabel.text = self.selectedCell.titleLabel.text;
    
    // retreive index of selected cell
    NSInteger idx = [[self.scrollView subviews] indexOfObject:cell];
    
    // call delegate and hit didSelectRow method
    if ([self.delegate respondsToSelector:@selector(dropList:didSelectRow:)])
        [self.delegate dropList:self didSelectRow:idx];
    
    // automatically close scroll view
    [self closeScrollView];
}

#pragma mark -
#pragma mark Building views
#pragma mark -

- (void)openScrollView
{
    if (!self.enabled)
        return;
    
    [self.scrollView.layer removeAllAnimations];
    
    // warn delegate scroll view is about to open
    if ([self.delegate respondsToSelector:@selector(dropList:willOpenScrollView:)])
        [self.delegate dropList:self willOpenScrollView:self.scrollView];
    
    // Fix for landscape orientation
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]))
    {
        if ([self.delegate isKindOfClass:[UIViewController class]])
        {
            // update scrollview position
            CGPoint p = [self.superview convertPoint:self.frame.origin toView:((UIViewController*)self.delegate).view];
            self.scrollView.frame = (CGRect){CGPointMake(p.x + self.padding, p.y +  self.frame.size.height),CGSizeMake(self.frame.size.width - self.padding * 2, self.frame.size.height)};
            [((UIViewController*)self.delegate).view addSubview:self.scrollView];
        }
    } else {
        // update scrollview position
        CGPoint p = [self.superview convertPoint:self.frame.origin toView:self.rootview];
        self.scrollView.frame = (CGRect){CGPointMake(p.x + self.padding, p.y + self.frame.size.height),CGSizeMake(self.frame.size.width - self.padding * 2, self.frame.size.height)};
        [self.rootview addSubview:self.scrollView];
    }
    
    self.scrollView.layer.shadowRadius = 50;
    self.scrollView.layer.shadowOpacity = 1;
    self.scrollView.layer.shadowOffset = CGSizeMake(1, 50);
    self.scrollView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.scrollView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.scrollView.bounds].CGPath;
    
    // animate
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x,
                                                        self.scrollView.frame.origin.y,
                                                        self.scrollView.frame.size.width,
                                                        self.expectedHeight);
                     }
                     completion:^(BOOL f){
                         if (f && [self.delegate respondsToSelector:@selector(dropList:didOpenScrollView:)] )
                         {
                             [self.delegate dropList:self didOpenScrollView:self.scrollView];
                         }
                         
                         [self.scrollView flashScrollIndicators];
                     }];
    
    //
    //	// add to parent subview
    //	[[self superview] addSubview:scrollview_];
    
}

- (void)closeScrollView
{
    // warn delegate scroll view is about to close
    if ([self.delegate respondsToSelector:@selector(dropList:willCloseScrollView:)])
        [self.delegate dropList:self willCloseScrollView:self.scrollView];
    
    
    self.scrollView.layer.shadowOpacity = 0.0f;
    
    // remove all previous animations
    [self.scrollView.layer removeAllAnimations];
    
    // animate move back and when done, remove from super view
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, 0);
                     }
                     completion:^(BOOL f){
                         if (f)
                             [self.scrollView removeFromSuperview];
                         if (f && [self.delegate respondsToSelector:@selector(dropList:didCloseScrollView:)] )
                             [self.delegate dropList:self didCloseScrollView:self.scrollView];
                         
                     }];
}

- (NSInteger)selectedRow
{
    // negative value to show no cell was selected
    if (self.selectedCell == nil)
        return -1;
    
    return [[self.scrollView subviews] indexOfObject:self.selectedCell];
}

- (void)selectRow:(NSInteger)index
{
    SNSDropListViewCell* cell = nil;
    if (index >= 0 && index < [[self.scrollView subviews] count])
        cell = [[self.scrollView subviews] objectAtIndex:index];
    
    [cell setSelected:YES animated:YES];
    self.selectedCell = cell;
}


- (void)reloadData
{
    if (!self.delegate || !self.dataSource)
        return;
    
    self.selectedCell = nil;
    
    // -----------------------------
    // Measurement
    // -----------------------------
    CGFloat height = 0.0f;
    NSInteger rows = 0;
    CGFloat y = 0;
    
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInDropList:)])
        rows = [self.dataSource numberOfRowsInDropList:self];
    
    if ([self.delegate respondsToSelector:@selector(dropList:heightForRow:)])
    {
        for (NSInteger i = 0; i < rows; ++i)
            height += [self.delegate dropList:self heightForRow:i];
    }
    else
        height = rows*kSnSDropListLabelDefaulttHeight;
    
    
    
    // -----------------------------
    // Update Scroll View
    // -----------------------------
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x,
                                   self.scrollView.frame.origin.y,
                                   self.scrollView.frame.size.width,
                                   height > self.maxScrollHeight ? self.maxScrollHeight : height);
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.origin.x, height);
    
    // Update expectedHeight used for future animation
    self.expectedHeight = self.scrollView.frame.size.height;
    
    // put scroll view height back to 0
    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, 0);
    
    // -----------------------------
    // Build Scroll View
    // -----------------------------
    for (NSInteger i = 0; i < rows; ++i)
    {
        SNSDropListViewCell* cell = nil;
        
        if ([self.delegate respondsToSelector:@selector(dropList:cellForRow:)])
            cell = [self.delegate dropList:self cellForRow:i];
        
        if ([self.delegate respondsToSelector:@selector(dropList:heightForRow:)])
            height = [self.delegate dropList:self heightForRow:i];
        else
            height = kSnSDropListLabelDefaulttHeight;
        
        // Update frame
        cell.userInteractionEnabled = YES;
        cell.frame = CGRectMake(0, y, self.scrollView.frame.size.width, height);
        
        //custom cell
        cell.titleLabelDefaultColor = self.labelCellDefaultColor;
        cell.titleLabelSelectedColor = self.labelCellSelectedColor;
        cell.backgroundSelectedColor = self.labelCellBackgroundSelectedColor;
        cell.titleLabelFont = self.labelCellFont;
        
        
        // add gesture recognizer
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(onTapCellView:)];
        tap.numberOfTapsRequired = 1;
        [cell addGestureRecognizer:tap];
        
        // add to subview
        [self.scrollView addSubview:cell];
        
        // update new position
        y += height;
    }
    
    
}

#pragma mark -
#pragma mark Custom Color Element
#pragma mark -

-(void)setMainLabelColor:(UIColor *)mainLabelColor
{
    self.mainLabelColor = nil;
    self.mainLabel.textColor = self.mainLabelColor;
}


-(void)setScrollViewColorBorder:(UIColor *)scrollViewColorBorder
{
    self.scrollViewColorBorder = nil;
    
    // border scrollView
    [[self.scrollView layer] setBorderWidth:1.0f];
    [[self.scrollView layer] setBorderColor:self.scrollViewColorBorder.CGColor];
}

-(void)setMainLabelFont:(UIFont *)mainLabelFont
{
    self.mainLabelFont = nil;
    self.mainLabel.font = self.mainLabelFont
}

-(void)defaultMainLabel
{
    self.mainLabel.textColor = self.mainLabelColor;
    self.mainLabel.font = self.mainLabelFont;
}


@end
