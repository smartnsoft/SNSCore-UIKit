//
//  UIColor+SNSCoreUIKit.h
//  Pods
//
//  Created by Jean-Charles SORIN on 21/05/2015.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (SNSCoreUIKit)

+ (UIColor*)colorFromHexa:(NSString*)hexaString;
+ (UIColor*)colorFromHexa:(NSString*)hexaString alpha:(CGFloat)alpha;

@end
