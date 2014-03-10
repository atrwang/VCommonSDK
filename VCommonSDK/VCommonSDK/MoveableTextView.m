//
//  MoveableTextView.m
//  VCommonSDK
//
//  Created by kevin on 3/6/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import "MoveableTextView.h"

#define kMoveableTextViewTopMargin 20
#define kMoveableTextViewRightMargin 20

@interface MoveableTextView()<UITextViewDelegate>{
    
    BOOL isTextViewActive;
}

@property (strong,nonatomic)UIColor* activeBgColor;
@property (strong,nonatomic)UIColor* activeBorderColor;
@property (strong,nonatomic)UIColor* inActiveBgColor;
@property (strong,nonatomic)UIColor* inActiveBorderColor;

@property (strong,nonatomic,readwrite)UIImageView* scaleImageView;

@end


@implementation MoveableTextView

- (id)initWithFrame:(CGRect)frame activeBackgroundColor:(UIColor*)activeColor activeBorderColor:(UIColor*)activeBorderColor inActiveBackgroundColor:(UIColor*)inActiveColor inActiveBorderColor:(UIColor*)inActiveBorderColor{
    
    self = [self initWithFrame:frame];
    
    if (self) {
        
        self.activeBgColor = activeColor;
        self.activeBorderColor = activeBorderColor;
        self.inActiveBgColor = inActiveColor;
        self.inActiveBorderColor = inActiveBorderColor;
        
        [self setActive:YES];
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        _closeButton.frame = CGRectMake(frame.size.width-37.0f,5, 32, 32);
        [self addSubview:_closeButton];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, kMoveableTextViewTopMargin, frame.size.width-kMoveableTextViewRightMargin, frame.size.height-kMoveableTextViewTopMargin)];
        [self addSubview:self.textView];
        
        self.activeBgColor = [UIColor lightGrayColor];
        self.activeBorderColor = [UIColor grayColor];
        self.inActiveBgColor = [UIColor clearColor];
        self.inActiveBorderColor = [UIColor clearColor];
        
        self.textView.spellCheckingType = UITextSpellCheckingTypeNo;

        self.textView.delegate = self;
        self.textView.scrollEnabled = NO;
        
        UIPanGestureRecognizer* panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTextView:)];
        [self addGestureRecognizer:panG];
        
        [self setActive:YES];
        
    }
    return self;
}


- (BOOL)isActive{
    return isTextViewActive;
}

- (void)setActive:(BOOL)active{

    isTextViewActive = active;
    if (active) {
        self.textView.backgroundColor = self.activeBgColor;
        self.textView.layer.borderColor = self.activeBorderColor.CGColor;
        self.textView.layer.borderWidth = 2.0f;
        [self.superview bringSubviewToFront:self];
        [self.textView becomeFirstResponder];
        
        [self.closeButton setHidden:NO];
        [self.scaleImageView setHidden:NO];

    }else {
        self.textView.backgroundColor = self.inActiveBgColor;
        self.textView.layer.borderColor = self.inActiveBorderColor.CGColor;
        self.textView.layer.borderWidth = 0.0f;
        [self.textView resignFirstResponder];
        
        [self.closeButton setHidden:YES];
        [self.scaleImageView setHidden:YES];
    }
}

- (void)changeFrame:(CGRect)newFrame{
    self.frame = newFrame;
    self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, newFrame.size.width-kMoveableTextViewRightMargin, newFrame.size.height-kMoveableTextViewTopMargin);
    self.scaleImageView.frame = CGRectMake(self.frame.size.width-37.0f,self.frame.size.height-32.0f, 32, 32);
    self.closeButton.frame = CGRectMake(newFrame.size.width-37.0f,5, 32, 32);
}

- (void)setScaleViewImage:(UIImage*)image{
    if (self.scaleImageView == nil) {
        self.scaleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-37.0f,self.frame.size.height-32.0f, 32, 32)];
        self.scaleImageView.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer* panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panScaleImageView:)];
        [self.scaleImageView addGestureRecognizer:panG];
        
        [self addSubview:self.scaleImageView];
    }else {
        
    }
    
    self.scaleImageView.image = image;
}

- (void) adjustTextInputHeightForText:(NSString*)text animated:(BOOL)animated {
    
    int h1 = [text sizeWithFont:self.textView.font constrainedToSize:CGSizeMake(self.frame.size.width, 800.0f) lineBreakMode:NSLineBreakByWordWrapping].height+15.0f;
    
    [UIView animateWithDuration:(animated ? .1f : 0) animations:^
     {
         if (h1>self.frame.size.height) {
             [self changeFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h1+20.0f)];
         }
         
     } completion:^(BOOL finished){
         //
     }];
}



- (void)panTextView:(UIPanGestureRecognizer *)gestureRecognizer{
    
    CGPoint translation = [gestureRecognizer translationInView:self.superview];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGFloat centerX = gestureRecognizer.view.center.x + translation.x;
        CGFloat centerY = gestureRecognizer.view.center.y + translation.y;

        
        if ((centerY< self.superview.frame.size.height - gestureRecognizer.view.frame.size.height/2.0f -5.0f) &&
            centerY > gestureRecognizer.view.frame.size.height/2.0f +5 &&
            centerX > 2.0f + gestureRecognizer.view.frame.size.width/2.0f &&
            (centerX < self.superview.frame.size.width - gestureRecognizer.view.frame.size.width/2.0f -2.0f)) {
            gestureRecognizer.view.center = CGPointMake(centerX,centerY);
        }
        
        [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
    }
}

- (void)panScaleImageView:(UIPanGestureRecognizer *)gestureRecognizer{
    
    CGPoint translation = [gestureRecognizer translationInView:self.superview];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged){
        
        CGFloat newWidth = self.frame.size.width;
            newWidth += translation.x;
            
            if (newWidth+self.frame.origin.x> self.superview.frame.size.width) {
                newWidth = self.superview.frame.size.width - self.frame.origin.x;
            }else if (newWidth< kMoveableTextViewMinWidth){
                newWidth = kMoveableTextViewMinWidth;
            }

        
        CGFloat newHeight = self.frame.size.height;
            newHeight += translation.y;
            
            if (newHeight+self.frame.origin.y> self.superview.frame.size.height) {
                newHeight = self.superview.frame.size.height - self.frame.origin.y;
            }else if (newHeight< kMoveableTextViewMinHeight){
                newHeight = kMoveableTextViewMinHeight;
            }
        
        [self changeFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, newHeight)];

        NSLog(@"%@",NSStringFromCGPoint(translation));
        
        [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
    }
    

}

#pragma mark UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text length] == 0) {
        double delayInSeconds = .1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [textView removeFromSuperview];
        });
    }
    [self setActive:NO];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self setActive:YES];
}

- (BOOL) textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
    
    if ([text isEqualToString:@"\n"]){
        [self adjustTextInputHeightForText:[NSString stringWithFormat:@"%@%@ ", textView.text, text] animated:YES];
    } else if (text.length > 0){
        [self adjustTextInputHeightForText:[NSString stringWithFormat:@"%@%@", textView.text, text] animated:YES];
    }
    return YES;
}

- (void) textViewDidChange:(UITextView*)textView {
    
    [self adjustTextInputHeightForText:textView.text animated:YES];
}

@end
