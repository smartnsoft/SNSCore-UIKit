//
//  UIColor+SNSCoreUIKit.m
//  Pods
//
//  Created by Roaflin on 3/5/15.
//
//

#import "UIColor+SNSCoreUIKit.h"

@implementation UIColor (SNSCoreUIKit)


/**
 *  Convert Hexadecimal color in RGB color
 *
 *  @param color The Hexadecimal color string
 *
 *  @return the right UIColor from the Hexadecimal string
 */
+ (UIColor *) colorFromWebColor:(NSString *)color
{
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;
    UIColor *result = nil;
    
    if (sscanf([color UTF8String], "#%2tx%2tx%2tx", &red, &green, &blue) == 3) {
        result = [UIColor colorWithRed:(red / 255.0) green:(green / 255.0) blue:(blue / 255.0) alpha:1.0];
    }
    
    return result;
}


@end
