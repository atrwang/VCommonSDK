//
//  VProgressHUD.m
//  VCommonSDK
//
//  Created by kevin on 2/15/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import "VProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

@interface VProgressHUDOverlayView:UIView
@property (nonatomic) VProgressHUDMaskType maskType;
@end


@implementation VProgressHUDOverlayView

- (void)drawRect:(CGRect)rect{
    
    if (self.maskType == VProgressHUDMaskTypeDim) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        size_t locationsCount = 2;
        CGFloat locations[2] = {0.0f, 1.0f};
        CGFloat colors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
        CGColorSpaceRelease(colorSpace);
        
        CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        float radius = MIN(self.bounds.size.width , self.bounds.size.height) ;
        CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient);
    }
}

@end



@interface VProgressHUD (){

    BOOL isShow;
}
@property (nonatomic) VProgressHUDMaskType maskType;
@property (strong,nonatomic) VProgressHUDOverlayView *overlayView;
@property (strong,nonatomic) UIImageView*   hudBgImageView;

@property (strong,nonatomic) CAShapeLayer*   hudBgImageViewMaskLayer;

@property (strong,nonatomic)NSTimer* dismissDelayTimer;

@end



@implementation VProgressHUD


+ (VProgressHUD*)sharedInstance {
    static dispatch_once_t onceToken;
    static VProgressHUD *instance;
    dispatch_once(&onceToken, ^{
        instance = [[VProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        instance.backgroundColor = [UIColor clearColor];
        instance.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        instance.userInteractionEnabled = NO;
        instance->isShow = NO;
        
        instance.hudBgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        instance.hudBgImageView.backgroundColor = [UIColor clearColor];
        [instance addSubview:instance.hudBgImageView];
        
    });
    
    return instance;
}

+ (void)showMsg:(NSString*)message dismissAfterDelay:(CGFloat)delay{
    
    [VProgressHUD showMsg:message image:nil withMaskType:VProgressHUDMaskTypeeNone dismissAfterDelay:delay];
}

+ (void)showMsg:(NSString*)message withMaskType:(VProgressHUDMaskType)mask dismissAfterDelay:(CGFloat)delay{
    [VProgressHUD showMsg:message image:nil withMaskType:mask dismissAfterDelay:delay];
}


+ (void)showMsg:(NSString*)message image:(UIImage*)image withMaskType:(VProgressHUDMaskType)mask dismissAfterDelay:(CGFloat)delay{
    [[VProgressHUD sharedInstance] show:message image:image withMaskType:mask dismissAfterDelay:delay];
}

+ (void)dismissWithAnimationDuration:(CGFloat)duration{

}


+ (BOOL)isVisible{
    
    return YES;
}


//instance method

- (void)setupOverlayView{
    
    VProgressHUDMaskType lastType = VProgressHUDMaskTypeeNone;
    if (self.overlayView) {
        lastType = self.overlayView.maskType;
    }
    [self.overlayView removeFromSuperview];
    self.overlayView = nil;
    self.overlayView = [[VProgressHUDOverlayView alloc] initWithFrame:self.bounds];
    _overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _overlayView.backgroundColor = [UIColor clearColor];
    
    self.overlayView.maskType = self.maskType;
    
    if(self.maskType != VProgressHUDMaskTypeeNone) {//have mask,拦截 touch
        self.userInteractionEnabled = YES;
        self.overlayView.userInteractionEnabled = YES;
        
    } else {
        self.userInteractionEnabled = NO;
        self.overlayView.userInteractionEnabled = NO;
    }
    
    [self addSubview:self.overlayView];
    
    if (lastType != VProgressHUDMaskTypeDim) {
        self.overlayView.alpha = .0f;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.overlayView.alpha = 1.0f;
        } completion:nil];
    }
}

- (void)setupHUDViewWithMessage:(NSString*)message image:(UIImage*)image{

    self.hudBgImageView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.hudBgImageView.alpha = 1.0f;
    } completion:^(BOOL finished){
    
        CGFloat imageHight = 0;
        UIImageView* imgV = (UIImageView*)[self.hudBgImageView viewWithTag:1212111];
        if (image) {//传入了image
            imageHight = 32.0f;
            if (!imgV) {
                imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageHight, imageHight)];
                imgV.tag = 1212111;
                [self.hudBgImageView addSubview:imgV];
            }else {
                imgV.frame = CGRectMake(0, 0, imageHight, imageHight);
            }
            
            imgV.image = image;
            
        }else {//没有传入image
            [imgV setFrame:CGRectZero];
        }
        
        CGSize size = CGSizeZero;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
        CGRect stringRect = [message boundingRectWithSize:CGSizeMake(200.0f, 500.0f) options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]} context:NULL];

        size = CGSizeMake(stringRect.size.width, stringRect.size.height);
#else
        size = [message sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(200.0f, 500.0f) lineBreakMode:NSLineBreakByWordWrapping];
#endif
        



        CGFloat textHight = 0;
        UILabel* textLabel = (UILabel*)[self.hudBgImageView viewWithTag:1212123];
        if (size.width>0 && size.height>0) {//传入了image
            textHight = size.height + 10;
            if (!textLabel) {
                textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, textHight)];
                textLabel.tag = 1212123;
                textLabel.font = [UIFont systemFontOfSize:16.0f];
                textLabel.textAlignment = NSTextAlignmentCenter;
                textLabel.textColor = [UIColor whiteColor];
                [self.hudBgImageView addSubview:textLabel];
            }else {
                textLabel.frame = CGRectMake(0, 0, size.width, textHight);
            }
            
            textLabel.text = message;
            
        }else {//没有传入image
            [textLabel setFrame:CGRectZero];
        }
        
        
        self.hudBgImageView.frame = CGRectMake(0, 0, size.width>64.0f?size.width:64.0f, 16.0f+imageHight+10.0f+textHight+6.0f);
        self.hudBgImageView.center = self.center;
        
        
        [self.hudBgImageViewMaskLayer removeFromSuperlayer];
        if (!image) {
            UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:self.hudBgImageView.bounds
                                                            byRoundingCorners:UIRectCornerAllCorners
                                                                  cornerRadii:CGSizeMake(7.0, 7.0)];
            
            self.hudBgImageViewMaskLayer = [CAShapeLayer layer];
            self.hudBgImageViewMaskLayer.frame = self.hudBgImageView.bounds;
            self.hudBgImageViewMaskLayer.path = shapePath.CGPath;
            self.hudBgImageViewMaskLayer.fillColor = [UIColor blackColor].CGColor;
            self.hudBgImageViewMaskLayer.strokeColor = [UIColor blackColor].CGColor;
            self.hudBgImageViewMaskLayer.lineWidth = 2;
            [self.hudBgImageView.layer addSublayer:self.hudBgImageViewMaskLayer];
        }
        
        
        [self.hudBgImageView bringSubviewToFront:imgV];
        [self.hudBgImageView bringSubviewToFront:textLabel];
        imgV.center = CGPointMake(self.hudBgImageView.frame.size.width/2, imgV.frame.size.height/2+16.0f);
        
        CGFloat sapceH = imgV.frame.size.height>10?16.0f+imgV.frame.size.height+10:0;
        
        textLabel.center = CGPointMake(self.hudBgImageView.frame.size.width/2, 16.0f+sapceH+textLabel.frame.size.height/2);
    }];
}

- (void)dismissTimerFired{
    [self dismissAnimationDuration:0.2];
}

- (void)show:(NSString*)message image:(UIImage*)image withMaskType:(VProgressHUDMaskType)mask dismissAfterDelay:(CGFloat)delay{
    
    self.maskType = mask;
    isShow = YES;
    
    //self
    if ([self superview] == nil) {
        NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
        
        for (UIWindow *window in frontToBackWindows){
            if (window.windowLevel == UIWindowLevelNormal) {
                
                [window addSubview:self];
                
                break;
            }
        }
    }
    
    //overlay
    [self setupOverlayView];
    

    //hud
    [self setupHUDViewWithMessage:message image:image];
    

    
    
    [self.dismissDelayTimer invalidate];
    self.dismissDelayTimer = nil;
    self.dismissDelayTimer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(dismissTimerFired) userInfo:nil repeats:NO];
}

- (void)dismissAnimationDuration:(CGFloat)duration{
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.overlayView.alpha = 0;
                         self.hudBgImageView.alpha = 0.5f;
                     }
                     completion:^(BOOL finished){
                         [self.overlayView removeFromSuperview];
                         self.overlayView = nil;
                         [self removeFromSuperview];
                     }];

}



- (void)setHudBgImage:(UIImage*)image{

}

@end
