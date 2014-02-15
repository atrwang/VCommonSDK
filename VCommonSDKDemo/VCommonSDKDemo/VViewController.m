//
//  VViewController.m
//  VCommonSDKDemo
//
//  Created by kevin on 2/15/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import "VViewController.h"

@interface VViewController ()

@end

@implementation VViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* s = @"abcw王位";
    
    if ([s hasChineseCharacter]) {
        NSLog(@"I have chinese!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
