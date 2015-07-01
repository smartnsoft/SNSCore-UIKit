//
//  SNSTransitionManager.h
//  Pods
//
//  Created by Florian Basso on 01/07/2015.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SNSTransitionType){
    SNSTransitionTypeLeftToRight = 0,
    SNSTransitionTypeRightToLeft,
    SNSTransitionTypeAirDimiss,
    SNSTransitionTypeAirShow
};

@interface SNSTransitionManager : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) SNSTransitionType transitionType;
@property (nonatomic, assign) NSTimeInterval transitionDuration;


@property (weak, nonatomic) UIView *backgroundView;
@property (nonatomic) BOOL useBackgroundView;

+ (instancetype)sharedInstance;

@end
