//
//  SNSDropListViewCell.m
//  Pods
//
//  Created by Florian Basso on 10/04/2015.
//
//

#import "SNSDropListViewCell.h"


@interface SNSDropListViewCell()

@property (weak, nonatomic) UIColor *cellBackgroundSelectedColor;
@property (weak, nonatomic) UIColor *cellBackgroundDefaultColor;
@property (weak, nonatomic) UIColor *cellTextDefaultColor;
@property (weak, nonatomic) UIColor *cellTextSelectedColor;

@end


@implementation SNSDropListViewCell

#pragma mark - Lazy Instantiation
- (UIColor *)cellBackgroundSelectedColor
{
    if (!_cellBackgroundSelectedColor)
        _cellBackgroundSelectedColor = [UIColor colorWithRed:2.0f/255.0f green:50.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
    
    return _cellBackgroundSelectedColor;
}

- (UIColor *)cellBackgroundDefaultColor
{
    if (!_cellBackgroundDefaultColor)
        _cellBackgroundDefaultColor = [UIColor clearColor];

    return _cellBackgroundDefaultColor;
}

- (UIColor *)cellTextDefaultColor
{
    if (!_cellTextDefaultColor)
        _cellTextDefaultColor = [UIColor blackColor];

    return _cellTextDefaultColor;
}

- (UIColor *)cellTextSelectedColor
{
    if (!_cellTextSelectedColor)
        _cellTextSelectedColor = [UIColor whiteColor];
    
    return _cellTextSelectedColor;
    
}

#pragma mark - Setters
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.titleLabel)
    {
        self.titleLabel.frame = CGRectMake(10, 0, frame.size.width-10, frame.size.height);
    }
}


-(void)setTitleLabelDefaultColor:(UIColor *)titleLabelDefaultColor
{
    self.titleLabelDefaultColor  = nil;
    self.titleLabelDefaultColor = titleLabelDefaultColor;
    self.titleLabel.textColor = self.titleLabelDefaultColor;
}

-(void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    
    self.titleLabelFont = nil;
    
    self.titleLabelFont = titleLabelFont;
    
    self.titleLabel.font = self.titleLabelFont;
}

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-10, frame.size.height)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = self.cellBackgroundDefaultColor;
        
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

#pragma mark - Deallocalization
-(void)dealloc
{
    self.titleLabelDefaultColor = nil;
    self.titleLabelSelectedColor = nil;
    self.backgroundSelectedColor = nil;
    self.titleLabelFont = nil;
}

#pragma mark - Selection Management
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected)
    {
        self.backgroundColor = self.backgroundSelectedColor;
        
        self.titleLabel.backgroundColor = self.backgroundSelectedColor;
        self.titleLabel.textColor = self.titleLabelSelectedColor;
    }
    else
    {
        self.backgroundColor = self.cellBackgroundDefaultColor;
        
        self.titleLabel.backgroundColor = self.cellBackgroundDefaultColor;
        self.titleLabel.textColor = self.titleLabelDefaultColor;
    }
}

@end
