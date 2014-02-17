//
//  NSOperationDownloadOperation.m
//  VCommonSDK
//
//  Created by kevin on 2/17/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import "NSOperationDownloadOperation.h"
@interface NSOperationDownloadOperation()

@property (weak,nonatomic)id delegate;
@property (strong,nonatomic)id downloadUrl;
@property (strong,nonatomic)NSDictionary* userinfo;

@property (nonatomic)long long expectedDataLength;
@property (strong,nonatomic)NSMutableData* downloadedData;

@end


@implementation NSOperationDownloadOperation

- (id)initWithUrl:(NSString*)fileUrl delegate:(id<NSOperationDownloadOperationDelegate>)delegate userinfo:(NSDictionary*)userinfo{
    
    if (self == [super init]) {
        self.delegate = delegate;
        self.downloadUrl = fileUrl;
        self.userinfo = userinfo;
        self.expectedDataLength = 0;
        self.downloadedData = [NSMutableData data];
    }
    
    return self;
}

- (void)main{
    @autoreleasepool {
        if (self.isCancelled) {
            return;
        }
        
    }
}



@end
