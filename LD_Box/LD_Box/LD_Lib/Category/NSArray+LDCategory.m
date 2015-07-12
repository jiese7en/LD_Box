//
//  NSArray+LDCategory.m
//  LD_Box
//
//  Created by Jay on 15/6/11.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSArray+LDCategory.h"
#import "LDBluzDeviceModel.h"
#import "LDDevice.h"

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



+ (NSMutableArray *)sortDeviceArr:(NSMutableArray *)arr {
    NSArray *newArr = [arr sortedArrayUsingComparator:^(id obj1,id obj2) {
        LDBluzDeviceModel *m1 = (LDBluzDeviceModel *)obj1;
        LDBluzDeviceModel *m2 = (LDBluzDeviceModel *)obj2;
        
        CBPeripheral *device1 = m1.peripheral;
        NSString *name1 = m1.deviceName;
        
        CBPeripheral *device2 = m2.peripheral;
        NSString *name2 = m2.deviceName;
        
        BOOL isConnected1 = NO;
        BOOL isConnected2 = NO;
        if (IS_LATER_IOS7) {
            isConnected1 = device1.state == CBPeripheralStateConnected ? YES : NO;
            isConnected2 = device2.state == CBPeripheralStateConnected ? YES : NO;
        } else {
            isConnected1 = device1.isConnected;
            isConnected2 = device2.isConnected;
        }
        
        if (isConnected1 && !isConnected2) {
            return (NSComparisonResult)NSOrderedAscending;
        } else if (!isConnected1 && isConnected2) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        return [name1 compare:name2 options:NSLiteralSearch];
    }];
    return [newArr mutableCopy];
}

@end
