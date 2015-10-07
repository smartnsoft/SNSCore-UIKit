//
//  UIImage+SNSCore.m
//  Pods
//
//  Created by Jean-Charles SORIN on 03/05/2015.
//
//

#import "UIImage+SNSCoreUIKit.h"

@implementation UIImage (SNSCoreUIKit)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


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


+ (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:name];
}

+ (NSString *)saveImage:(UIImage*)image withName:(NSString*)name
{
    if (image != nil)
    {
        NSString* path = [UIImage documentsPathForFileName:name];
        NSData* data = UIImageJPEGRepresentation(image, 0.8);
        [data writeToFile:path atomically:YES];
        return path;
    }
    return @"";
}

+ (void)removeImage:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (!success)
    {
        [UIImage removeImage:filePath];
    }
}
@end
