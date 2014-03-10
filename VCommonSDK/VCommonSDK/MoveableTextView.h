//
//  MoveableTextView.h
//  VCommonSDK
//
//  Created by kevin on 3/6/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kMoveableTextViewMinWidth 300.0f
#define kMoveableTextViewMinHeight 100.0f

@interface MoveableTextView : UIView

@property (nonatomic,readonly) BOOL isActive;

@property (strong,nonatomic)UITextView* textView;

@property (strong,nonatomic)UIButton* closeButton;

@property (strong,nonatomic,readonly)UIImageView* scaleImageView;

- (id)initWithFrame:(CGRect)frame activeBackgroundColor:(UIColor*)activeColor activeBorderColor:(UIColor*)activeBorderColor inActiveBackgroundColor:(UIColor*)inActiveColor inActiveBorderColor:(UIColor*)inActiveBorderColor;

- (void)setActive:(BOOL)active;

- (void)setScaleViewImage:(UIImage*)image;

- (void) adjustTextInputHeightForText:(NSString*)text animated:(BOOL)animated;

@end
