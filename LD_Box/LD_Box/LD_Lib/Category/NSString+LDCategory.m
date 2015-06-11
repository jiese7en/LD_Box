//
//  NSString+LDCategory.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSString+LDCategory.h"
#import "LDDevice.h"

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

+ (NSString *)bytes2String:(Byte *)bytes length:(int)length encode:(int)encode {
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

- (CGSize)getUISize:(UIFont*)font limitWidth:(CGFloat)width {

    //注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    CGSize size = CGSizeMake(width, 20000.0f);
    if (IS_LATER_IOS7) {
        //iOS 7.0 以上
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        size =[self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    else
    {
#ifndef __IPHONE_7_0
        //iOS 6.0
        if ([self respondsToSelector:@selector(sizeWithFont:constrainedToSize:lineBreakMode:)]) {
            size = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        }
#endif
    }
    return size;
}


+ (NSString *)stringMinAndSecond:(UInt32)time {
    
    int seconds = (int)time/1000;
    int minute = 0;
    if (seconds >= 60) {
        int index = seconds / 60;
        minute = index;
        seconds = seconds - index * 60;
    }
    return [NSString stringWithFormat:@"%02d:%02d", minute, seconds];
}


+ (NSString *)convertLyricToString:(NSData *)lyricData {
    NSStringEncoding big5 = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5);
    NSStringEncoding gb2312 = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSStringEncoding utf16 = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF16);
    NSStringEncoding utf8 = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSStringEncoding kj = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingWindowsKoreanJohab);
    NSStringEncoding shiftJIS = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingShiftJIS);
    NSStringEncoding eucKR = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingEUC_KR);
    NSString* strLyric = nil;
    
    strLyric = [[NSString alloc] initWithData:lyricData encoding:utf8];
    if (strLyric == nil) {
        strLyric = [[NSString alloc] initWithData:lyricData encoding:gb2312];
    }
    if (strLyric == nil) {
        strLyric = [[NSString alloc] initWithData:lyricData encoding:big5];
    }
    if (strLyric == nil) {
        strLyric = [[NSString alloc] initWithData:lyricData encoding:utf16];
    }
    if (strLyric == nil) {
        strLyric = [[NSString alloc] initWithData:lyricData encoding:kj];
    }
    if (strLyric == nil) {
        strLyric = [[NSString alloc] initWithData:lyricData encoding:shiftJIS];
    }
    if (strLyric == nil) {
        strLyric = [[NSString alloc] initWithData:lyricData encoding:eucKR];
    }
    
    if (strLyric == nil) {
        NSLog(@"Lyric encoding not supportted!");
    }
    
    return strLyric;
}


+ (NSString *)timeToSecond:(NSString *)formatTime {
    
    if (!formatTime || formatTime.length <= 9) {
        return @"0.0";
    }
    
    if ([formatTime rangeOfString:@"["].length <= 0 && [formatTime rangeOfString:@"]"].length <= 0) {
        return @"0.0";
    }
    
    NSString * minutes = [formatTime substringWithRange:NSMakeRange(1, 2)];
    NSString * second = [formatTime substringWithRange:NSMakeRange(4, 5)];
    float finishSecond = minutes.floatValue * 60 + second.floatValue;
    return [NSString stringWithFormat:@"%f",finishSecond];
}

@end
