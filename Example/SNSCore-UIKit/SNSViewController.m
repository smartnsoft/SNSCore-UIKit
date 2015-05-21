//
//  SNSViewController.m
//  SNSCore-UIKit
//
//  Created by FlorianBasso on 05/03/2015.
//  Copyright (c) 2014 FlorianBasso. All rights reserved.
//

#import "SNSViewController.h"
#import <SNSCore-UIKit/UIView+SNSCoreUIKit.h>
#import <SNSCore-UIKit/UIColor+SNSCoreUIKit.h>

@interface SNSViewController ()

@end

@implementation SNSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // DropListView Example
    SNSDropListView * dropListView = [[SNSDropListView alloc] initWithFrame:self.view.frame];
    [dropListView setBackgroundColor:[UIColor colorFromHexa:@"#f587e4"]];
    [dropListView setDelegate:self];
    [dropListView setDataSource:self];
    [dropListView cutSide:CutterViewSideTypeLeft];
    [self.view addSubview:dropListView];
    
    
    // Rounded View Example
    UIView * roundedView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    [roundedView setBackgroundColor:[UIColor colorFromHexa:@"538535"]];
    [roundedView setRoundedCorners:UIRectCornerAllCorners radius:CGSizeMake(50, 50)];
    [dropListView addSubview:roundedView];
    
    // Fade IN/OUT Example
    [roundedView fadeFromInitialAlpha:0.0f finalAlpha:0.7f andDuration:2.0f];
}

#pragma mark - SNSDropListView Delegate
- (SNSDropListViewCell*)dropList:(SNSDropListView*)iDropList cellForRow:(NSInteger)iRow
{
    SNSDropListViewCell * dropListViewCell = [[SNSDropListViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [dropListViewCell setBackgroundColor:[UIColor colorFromHexa:@"#663482"]];
    return dropListViewCell;
}


#pragma mark - SNSDropListView Datasource
- (NSInteger)numberOfRowsInDropList:(SNSDropListView*)iDropListView
{
    return 5;
}

@end
