//
//  SNSViewTest.m
//  SNSCore-UIKit
//
//  Created by Roaflin on 3/5/15.
//  Copyright (c) 2015 FlorianBasso. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+SNSCoreUIKit.h"

@interface SNSViewTest : XCTestCase

@end

@implementation SNSViewTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 *  Test if the alpha has the right value after the fade animation
 */
- (void)testFade
{
    UIView *aView = [[UIView alloc] init];
    [aView fadeFromInitialAlpha:0.0f finalAlpha:0.7f andDuration:2.0f];
    XCTAssertEqual(aView.alpha, 0.7f, @"The alpha is not correct");
}

@end
