//
//  VProgressHUDViewController.m
//  VCommonSDKDemo
//
//  Created by kevin on 2/15/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import "VProgressHUDViewController.h"
#import "VProgressHUD.h"

@interface VProgressHUDViewController ()

@end

@implementation VProgressHUDViewController


- (IBAction)showCommon:(id)sender {
     NSLog(@"%s",__FUNCTION__);
    [VProgressHUD showMsg:@"hello" dismissAfterDelay:1.5];
}


- (IBAction)show:(id)sender {
     NSLog(@"%s",__FUNCTION__);
    [VProgressHUD showMsg:@"hello" withMaskType:VProgressHUDMaskTypeDim dismissAfterDelay:1.5f];
}

- (IBAction)showWithImage{

    NSLog(@"%s",__FUNCTION__);
    [VProgressHUD showMsg:@"hello" image:[UIImage imageNamed:@"test"] withMaskType:VProgressHUDMaskTypeDim dismissAfterDelay:1.5f];
}

@end
