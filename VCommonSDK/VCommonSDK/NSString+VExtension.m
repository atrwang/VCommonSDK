//
//  NSString+VExtension.m
//  VCommonSDK
//
//  Created by kevin on 2/15/14.
//  Copyright (c) 2014 OpenSource. All rights reserved.
//

#import "NSString+VExtension.h"

@implementation NSString (VExtension)


- (BOOL)hasChineseCharacter {
	BOOL isChinese = NO;
    
	int min1,min2,min3,min4,min5,min6,min7,min8,min9,min10,min11,min12,
	max1,max2,max3,max4,max5,max6,max7,max8,max9,max10,max11,max12;
    
	min1 = 0x3400;		max1 = 0x4DB5;	//CJK Unified Ideographs Extension A	3.0
	min2 = 0x4E00;		max2 = 0x9FA5;	//CJK Unified Ideographs				1.1
	min3 = 0x9FA6;		max3 = 0x9FBB;	//CJK Unified Ideographs				4.1
	min4 = 0xF900;		max4 = 0xFA2D;	//CJK Compatibility Ideographs			1.1
	min5 = 0xFA30;		max5 = 0xFA6A;	//CJK Compatibility Ideographs			3.2
	min6 = 0xFA70;		max6 = 0xFAD9;	//CJK Compatibility Ideographs			4.1
	min7 = 0x20000;		max7 = 0x2A6D6;	//CJK Unified Ideographs Extension B	3.1
	min8 = 0x2F800;		max8 = 0x2FA1D;	//CJK Compatibility Supplement			3.1
	min9  = 0xFF00;	    max9 = 0xFFEF;	//
	min10 = 0x2E80;		max10 = 0x2EFF;
	min11 = 0x3000;		max11 = 0x303F;
	min12 = 0x31C0;		max12 = 0x31EF;
	
	unichar *buffer = (unichar *)calloc([self length], sizeof(unichar));
	long len = [self length];
	NSRange range = NSMakeRange(0, len);
	[self getCharacters:buffer range:range];
	for (int i=0; i<[self length]; i++) {
		if (buffer[i] > min1 && buffer[i] < max1) isChinese = YES;
		if (buffer[i] > min2 && buffer[i] < max2) isChinese = YES;
		if (buffer[i] > min3 && buffer[i] < max3) isChinese = YES;
		if (buffer[i] > min4 && buffer[i] < max4) isChinese = YES;
		if (buffer[i] > min5 && buffer[i] < max5) isChinese = YES;
		if (buffer[i] > min6 && buffer[i] < max6) isChinese = YES;
		if (buffer[i] > min7 && buffer[i] < max7) isChinese = YES;
		if (buffer[i] > min8 && buffer[i] < max8) isChinese = YES;
		if (buffer[i] > min9 && buffer[i] < max9) isChinese = YES;
		if (buffer[i] > min10 && buffer[i] < max10) isChinese = YES;
		if (buffer[i] > min11 && buffer[i] < max11) isChinese = YES;
		if (buffer[i] > min12 && buffer[i] < max12) isChinese = YES;
	}
	free(buffer);
	return isChinese;
}


- (NSString*)trim {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
