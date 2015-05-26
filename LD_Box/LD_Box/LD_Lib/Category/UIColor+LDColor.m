//
//  UIColor+LDColor.m
//  LD_Box
//
//  Created by Jay on 15-5-22.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "UIColor+LDColor.h"

@implementation UIColor (LDColor)



+ (UIColor *)colorWithHexRGB:(NSInteger)rgbValue
{
    return  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)colorWithHexRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha
{
    return  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}


@end
