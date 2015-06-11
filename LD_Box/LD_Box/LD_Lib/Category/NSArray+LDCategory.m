//
//  NSArray+LDCategory.m
//  LD_Box
//
//  Created by Jay on 15/6/11.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSArray+LDCategory.h"

@implementation NSArray (LDCategory)


// 以时间顺序进行排序
+ (void)sortByTime:(NSMutableArray *)array {
    if (!array || array.count <= 0) {
        return;
    }
    
    for (int i = 0; i < array.count - 1; i++)
    {
        for (int j = i + 1; j < array.count; j++)
        {
            id firstDic = [array objectAtIndex:(NSUInteger )i];
            id secondDic = [array objectAtIndex:(NSUInteger)j];
            if (firstDic && [firstDic isKindOfClass:[NSDictionary class]] && secondDic && [secondDic isKindOfClass:[NSDictionary class]])
            {
                NSString *firstTime = [[firstDic allKeys] objectAtIndex:0];
                NSString *secondTime = [[secondDic allKeys] objectAtIndex:0];
                BOOL b = firstTime.floatValue > secondTime.floatValue;
                if (b) // 第一句时间大于第二句，就要进行交换
                {
                    [array replaceObjectAtIndex:(NSUInteger )i withObject:secondDic];
                    [array replaceObjectAtIndex:(NSUInteger )j withObject:firstDic];
                }
            }
        }
    }
}

@end
