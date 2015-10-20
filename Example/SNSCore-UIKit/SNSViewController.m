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
    UIView * view = [[UIView alloc] initWithFrame:self.view.frame];
    [view setBackgroundColor:[UIColor colorFromHexa:@"#f587e4"]];
    [view cutSide:CutterViewSideTypeTop withDiagonal:100.0f];
    [self.view addSubview:view];
    
    // Rounded View Example
    UIView * roundedView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    [roundedView setBackgroundColor:[UIColor colorFromHexa:@"538535"]];
    [roundedView setRoundedCorners:UIRectCornerAllCorners radius:CGSizeMake(50, 50)];
    [view addSubview:roundedView];
    
    // Fade IN/OUT Example
    [roundedView fadeFromInitialAlpha:0.0f finalAlpha:0.7f andDuration:2.0f];
}
@end
