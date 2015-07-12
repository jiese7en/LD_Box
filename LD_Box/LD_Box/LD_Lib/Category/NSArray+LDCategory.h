//
//  NSArray+LDCategory.h
//  LD_Box
//
//  Created by Jay on 15/6/11.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (LDCategory)


// 以时间顺序进行排序
+ (void)sortByTime:(NSMutableArray *)array;


/**
 *  排序
 *
 *  @param arr LDBluzDeviceModel的元素
 *
 *  @return arr
 */
+ (NSMutableArray *)sortDeviceArr:(NSMutableArray *)arr;

@end
