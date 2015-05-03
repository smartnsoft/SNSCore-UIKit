//
//  UIImage+SNSCore.h
//  Pods
//
//  Created by Jean-Charles SORIN on 03/05/2015.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (SNSCoreUIKit)

/**
 Transform your current UIImage with a black and white filter. <br/>
 Note : please be sure that this operation is called from a background thread according to hight CPU processing to transform the image.
 */
-(UIImage*)blackAndWhiteImage;

@end
