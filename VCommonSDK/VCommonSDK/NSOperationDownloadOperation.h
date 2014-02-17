//
//  NSOperationDownloadOperation.h
//  VCommonSDK
//
//  Created by kevin on 2/17/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSOperationDownloadOperation;
@protocol NSOperationDownloadOperationDelegate <NSObject>

- (void)downloadOperation:(NSOperationDownloadOperation*)operation userinfo:(NSDictionary*)userInfo  expectedDataLength:(long long)expectedDataLength totalDownloadLength:(long long)totalDownloadLength;

- (void)downloadOperationDidFinishedDownload:(NSOperationDownloadOperation*)operation withData:(NSData*)downlaodedData;

@end

@interface NSOperationDownloadOperation : NSOperation

@property (nonatomic)NSTimeInterval timeoutInterval;

- (id)initWithUrl:(NSString*)fileUrl delegate:(id<NSOperationDownloadOperationDelegate>)delegate userinfo:(NSDictionary*)userinfo;

@end
