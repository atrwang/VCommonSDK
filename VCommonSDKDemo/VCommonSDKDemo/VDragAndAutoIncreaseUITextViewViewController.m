//
//  VDragAndAutoIncreaseUITextViewViewController.m
//  VCommonSDKDemo
//
//  Created by kevin on 3/6/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import "VDragAndAutoIncreaseUITextViewViewController.h"
#import "MoveableTextView.h"

@interface VDragAndAutoIncreaseUITextViewViewController ()<UITextViewDelegate>
@property (strong,nonatomic)NSMutableArray* textViews;
@end

@implementation VDragAndAutoIncreaseUITextViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.textViews = [NSMutableArray array];
}

- (void)removeFromScreen:(UIButton*)button{
    MoveableTextView* v = (MoveableTextView*)[button superview];
    
    [v removeFromSuperview];
    [self.textViews removeObject:v];
}



#pragma mark - TouchEvent

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");

    BOOL alreadyFound = NO;
    CGPoint touch = [[touches anyObject] locationInView:self.view];
    
    for (MoveableTextView* existTextView in self.textViews) {
        CGPoint curPoint = [existTextView convertPoint:touch fromView:self.view];
       BOOL inSide = [existTextView pointInside:curPoint withEvent:nil];
        if (!alreadyFound && inSide) {
            [existTextView setActive:YES];
            alreadyFound = YES;
        }else {
            [existTextView setActive:NO];
            
            if ([existTextView.textView.text length] == 0 ) {
                
                [existTextView removeFromSuperview];
                [self.textViews removeObject:existTextView];
            }
        }
    }
    
    if (!alreadyFound) {
        MoveableTextView* textView = [[MoveableTextView alloc] initWithFrame:CGRectMake(touch.x, touch.y, 1024.0f-touch.x>kMoveableTextViewMinWidth?kMoveableTextViewMinWidth:1024.0f-touch.x, kMoveableTextViewMinHeight) activeBackgroundColor:[UIColor colorWithRed:.3f green:.3f blue:.3f alpha:0.3] activeBorderColor:[UIColor grayColor] inActiveBackgroundColor:[UIColor clearColor] inActiveBorderColor:[UIColor clearColor]];

        [textView.closeButton addTarget:self action:@selector(removeFromScreen:) forControlEvents:UIControlEventTouchUpInside];
        [textView setScaleViewImage:[UIImage imageNamed:@"test"]];
        [self.view addSubview:textView];
        [self.textViews addObject:textView];
        
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
        NSLog(@"touchesMoved");
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
        NSLog(@"touchesEnded");
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
        NSLog(@"touchesCancelled");
}

@end
