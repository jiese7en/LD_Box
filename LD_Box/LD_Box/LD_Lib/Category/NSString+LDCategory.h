//
//  NSString+LDCategory.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (LDCategory)

/**
 *  获取EncodeType
 *
 *  @param encode NSInteger
 *
 *  @return NSStringEncoding
 */
+ (NSStringEncoding)getEncodeType:(NSInteger)encode;


/**
 *  bytes2String
 *
 *  @param bytes  bytes
 *  @param length length
 *  @param encode encode
 *
 *  @return NSString
 */
+ (NSString *)bytes2String:(Byte*)bytes length:(int)length encode:(int)encode;



/**
 *  获取字符串Size
 *
 *  @param font  font
 *  @param width width
 *
 *  @return CGSize
 */
- (CGSize)getUISize:(UIFont*)font limitWidth:(CGFloat)width;

/**
 *  把UInt32类型转成时间字符串
 *
 *  @param time 例:250
 *
 *  @return 例:@"4:10"
 */
+ (NSString *)stringMinAndSecond:(UInt32)time;


/**
 *  把歌词NSData转成NSString
 *
 *  @return NSString
 */
+ (NSString *)convertLyricToString:(NSData *)lyricData;

/**
 *  转换成以秒为单位的时间计数器
 *
 *  @param formatTime 100
 *
 *  @return 0.0
 */
+ (NSString *)timeToSecond:(NSString *)formatTime;


@end
