//
//  UIColor+LDColor.h
//  LD_Box
//
//  Created by Jay on 15-5-22.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

@interface UIColor (LDColor)


/**
*  根据16进制RGB值，获取UIColor
*
*  @param rgbValue 例:0xD9D9D9
*
*  @return UIColor
*/
+ (UIColor *)colorWithHexRGB:(NSInteger)rgbValue;
+ (UIColor *)colorWithHexRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha;


@end
