//
//  UIImage+SNSCore.m
//  Pods
//
//  Created by Jean-Charles SORIN on 03/05/2015.
//
//

#import "UIImage+SNSCoreUIKit.h"

@implementation UIImage (SNSCoreUIKit)

-(UIImage *)blackAndWhiteImage
{
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    
    CIFilter *filterBlackAndWhite = [CIFilter filterWithName:@"CIColorMonochrome"];
    [filterBlackAndWhite setDefaults];
    [filterBlackAndWhite setValue:inputImage forKey:kCIInputImageKey];
    [filterBlackAndWhite setValue:[CIColor colorWithRed:1 green:1 blue:1] forKey:@"inputColor"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filterBlackAndWhite outputImage];
    CGImageRef cgiimage = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *newImage = [UIImage imageWithCGImage:cgiimage];
    
    CGImageRelease(cgiimage);
    
    return newImage;
}

@end
