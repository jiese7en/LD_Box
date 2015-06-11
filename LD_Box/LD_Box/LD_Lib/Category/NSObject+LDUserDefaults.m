//
//  NSObject+LDUserDefaults.m
//  LD_Box
//
//  Created by Jay on 15/6/11.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSObject+LDUserDefaults.h"

@implementation NSObject (LDUserDefaults)


+ (void)saveToUserDefaults:(id)value forKey:(NSString *)key

{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (userDefaults) {
        [userDefaults setObject:value forKey:key];
        [userDefaults synchronize];
    }
}


+ (id)getFromUserDefaults:(NSString *)key {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    id value = nil;
    if (key) {
        value = [userDefaults objectForKey:key];
    }
    return value;
}

@end
