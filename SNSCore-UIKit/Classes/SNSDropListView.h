//
//  SNSDropListView.h
//  Pods
//
//  Created by Florian Basso on 10/04/2015.
//
//

#import <UIKit/UIKit.h>
#import "SNSDropListViewCell.h"

@class SNSDropListView;

@protocol SnSDropListDelegate <NSObject>

- (SNSDropListViewCell*)dropList:(SNSDropListView*)iDropList cellForRow:(NSInteger)iRow;

@optional

- (void)didTapDropListView:(SNSDropListView*)iDropList;

- (void)dropList:(SNSDropListView*)iDropList didSelectRow:(NSInteger)iRow;
- (CGFloat)dropList:(SNSDropListView*)iDropList heightForRow:(NSInteger)iRow;

- (void)dropList:(SNSDropListView*)iDropList willOpenScrollView:(UIScrollView*)iScrollView;
- (void)dropList:(SNSDropListView*)iDropList didOpenScrollView:(UIScrollView*)iScrollView;

- (void)dropList:(SNSDropListView*)iDropList willCloseScrollView:(UIScrollView*)iScrollView;
- (void)dropList:(SNSDropListView*)iDropList didCloseScrollView:(UIScrollView*)iScrollView;

- (BOOL)dropList:(SNSDropListView*)iDropList shouldReceiveTap:(UIGestureRecognizer*)iGesture;

@end

@protocol SnSDropListDataSource <NSObject>

@required

- (NSInteger)numberOfRowsInDropList:(SNSDropListView*)iDropListView;

@end

@interface SNSDropListView : UIView

@property (nonatomic, strong) SNSDropListViewCell* selectedCell;

@property (nonatomic, weak) id<SnSDropListDelegate> delegate;
@property (nonatomic, weak) id<SnSDropListDataSource> dataSource;
@property (nonatomic, assign) CGFloat maxScrollHeight;
@property (nonatomic, assign) CGFloat expectedHeight;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) UILabel* mainLabel;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView* backgroundView;
@property (nonatomic, strong) UIImageView* arrowImage;
@property (nonatomic, strong) UIImageView* backgroundImage;

@property (nonatomic, strong) UIColor* mainLabelColor;
@property (nonatomic, strong) UIColor* scrollViewColorBorder;
@property (nonatomic, strong) UIColor* labelCellDefaultColor;
@property (nonatomic, strong) UIColor* labelCellSelectedColor;
@property (nonatomic, strong) UIColor* labelCellBackgroundSelectedColor;
@property (nonatomic, strong) UIFont* mainLabelFont;
@property (nonatomic, strong) UIFont* labelCellFont;

#pragma mark Internal Events

- (void)onTapMainView:(id)sender;
- (void)onTapCellView:(id)sender;

#pragma mark Actions

- (void)setup;
- (void)openScrollView;
- (void)closeScrollView;

#pragma mark Loading Data

- (void)reloadData;
- (NSInteger)selectedRow;
- (void)selectRow:(NSInteger)index;

// default colorMainLabel and default fontMainLabel
-(void)defaultMainLabel;


@end
