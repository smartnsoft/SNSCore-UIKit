//
//  UIColor+SNSCoreUIKit.m
//  Pods
//
//  Created by Jean-Charles SORIN on 21/05/2015.
//
//

#import "UIColor+SNSCoreUIKit.h"

@implementation UIColor (SNSCoreUIKit)

+ (UIColor*)colorFromHexa:(NSString*)hexaString
{
    return [UIColor colorFromHexa:hexaString alpha:1];
}

+ (UIColor*)colorFromHexa:(NSString*)hexaString alpha:(CGFloat)alpha
{
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;
    UIColor *colorGenerated = nil;
    
    if (sscanf([hexaString UTF8String], "#%2tx%2tx%2tx", &red, &green, &blue) == 3)
    {
        colorGenerated = [UIColor colorWithRed:(red / 255.0) green:(green / 255.0) blue:(blue / 255.0) alpha:alpha];
    }
    
    return colorGenerated;
}

@end
