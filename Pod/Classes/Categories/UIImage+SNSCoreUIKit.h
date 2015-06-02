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
 *   Transform your current UIImage with a black and white filter. <br/>
 Note : please be sure that this operation is called from a background thread according to hight CPU processing to transform the image.
*
*  @return an image in Black and White
*/
-(UIImage*)blackAndWhiteImage;

/**
 *  Return the document directory path
 *
 *  @param name Defines the name of the file, must be unique
 *
 *  @return full path of the new file
 */
+ (NSString *)documentsPathForFileName:(NSString *)name;


/**
 *  Save and store the image in the documents directory
 *
 *  @param image The image to save
 *  @param name  The name of the file in which the image will be save, must be unique
 *
 *  @return path of the new file
 */
+ (NSString *)saveImage:(UIImage*)image withName:(NSString*)name;

/**
 *  Remove a file from the hard drive
 *
 *  @param filePath Defines the path of the file
 */
+ (void)removeImage:(NSString *)filePath;
@end
