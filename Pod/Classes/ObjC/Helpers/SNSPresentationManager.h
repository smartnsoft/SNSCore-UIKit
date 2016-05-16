//
//  SNSPresentationManager.h
//  Pods
//
//  Created by Florian Basso on 01/07/2015.
//
//

#import <Foundation/Foundation.h>
#import "SNSTransitionManager.h"
#import <UIKit/UIKit.h>

@interface SNSPresentationManager : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic) SNSTransitionType transitionTypeShow;
@property (nonatomic) SNSTransitionType transitionTypeDismiss;

+ (instancetype)sharedInstance;
@end
