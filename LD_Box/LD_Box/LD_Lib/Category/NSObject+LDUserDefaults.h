//
//  NSObject+LDUserDefaults.h
//  LD_Box
//
//  Created by Jay on 15/6/11.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LDUserDefaults)

+ (void)saveToUserDefaults:(id)value forKey:(NSString *)key;

+ (id)getFromUserDefaults:(NSString *)key;

@end
