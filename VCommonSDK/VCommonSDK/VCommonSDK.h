//
//  VCommonSDK.h
//  VCommonSDK
//
//  Created by kevin on 2/15/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#if !__has_feature(objc_arc)
#error VCommonSDK is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif


#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_5_0
#error VCommonSDK need min system version 5.0
#endif

#import <Foundation/Foundation.h>

//NSObjective+Category
#import "NSString+VExtension.h"



//CustomView
#import "VProgressHUD.h"