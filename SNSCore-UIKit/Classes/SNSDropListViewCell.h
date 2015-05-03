//
//  SNSDropListViewCell.h
//  Pods
//
//  Created by Florian Basso on 10/04/2015.
//
//

#import <UIKit/UIKit.h>

@interface SNSDropListViewCell : UIView

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIColor* titleLabelDefaultColor;
@property (nonatomic, strong) UIColor* titleLabelSelectedColor;
@property (nonatomic, strong) UIColor* backgroundSelectedColor;
@property (nonatomic, strong) UIFont* titleLabelFont;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
