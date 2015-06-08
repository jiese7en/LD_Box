//
//  NSString+LDCategory.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSString+LDCategory.h"

@implementation NSString (LDCategory)

+ (NSStringEncoding)getEncodeType:(NSInteger)encode {
    if(encode == 0) {         //"GBK"
        return CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    }
    else if(encode == 1) {   //"UTF-16LE"
        return NSUTF16LittleEndianStringEncoding;
    }
    else if(encode == 2) {    //"UTF-16BE"
        return NSUTF16BigEndianStringEncoding;
    }
    else{                   //"UTF-8"
        return NSUTF8StringEncoding;
    }
}

+ (NSString *)bytes2String:(Byte*)bytes length:(int)length encode:(int)encode {
    NSStringEncoding type = [self getEncodeType:encode];
    int count = 0;
    if (type == NSUTF16LittleEndianStringEncoding || type == NSUTF16BigEndianStringEncoding) {
        while (count + 1 < length) {
            if (bytes[count] == 0 && bytes[count + 1] == 0) {
                break;
            }
            count += 2;
        }
    } else {
        while (count < length) {
            if (bytes[count] == '\0') {
                break;
            }
            count++;
        }
    }
    
    NSString* strRet = [[NSString alloc] initWithBytes:bytes length:count encoding:type];
    if (strRet != nil && strRet.length == 0) {
        strRet = nil;
    }
    return strRet;
}

@end
