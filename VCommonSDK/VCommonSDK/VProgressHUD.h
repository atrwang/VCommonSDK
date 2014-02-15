//
//  VProgressHUD.h
//  VCommonSDK
//
//  Created by kevin on 2/15/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

typedef enum _VProgressHUDMaskType {
    
        VProgressHUDMaskTypeeNone = 1, // allow user interactions while HUD is displayed
        VProgressHUDMaskTypeClear, // don't allow
        VProgressHUDMaskTypeDim, // don't allow and dim the UI at the back of the HUD

}VProgressHUDMaskType;

@interface VProgressHUD : UIView

//Shared Instance

//VProgressHUDMaskTypeeNone
//show HUD and dismiss after delay delay, when it show,use can interact
+ (void)showMsg:(NSString*)message dismissAfterDelay:(CGFloat)delay;


//
+ (void)showMsg:(NSString*)message withMaskType:(VProgressHUDMaskType)mask dismissAfterDelay:(CGFloat)delay;


+ (void)showMsg:(NSString*)message image:(UIImage*)image withMaskType:(VProgressHUDMaskType)mask dismissAfterDelay:(CGFloat)delay;

+ (void)dismissWithAnimationDuration:(CGFloat)duration;

+ (BOOL)isVisible;


- (void)setHudBgImage:(UIImage*)image;

@end

