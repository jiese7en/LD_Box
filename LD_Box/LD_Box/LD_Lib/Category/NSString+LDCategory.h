//
//  NSString+LDCategory.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LDCategory)

+ (NSStringEncoding)getEncodeType:(NSInteger)encode;

+ (NSString *)bytes2String:(Byte*)bytes length:(int)length encode:(int)encode;

@end
