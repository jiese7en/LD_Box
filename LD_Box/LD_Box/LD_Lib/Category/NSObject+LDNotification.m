//
//  NSObject+LDNotification.m
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSObject+LDNotification.h"

#pragma mark -

@implementation NSNotification(LDNotification)

- (BOOL)is:(NSString *)name
{
    return [self.name isEqualToString:name];
}

- (BOOL)isKindOf:(NSString *)prefix
{
    return [self.name hasPrefix:prefix];
}

@end

#pragma mark -

@implementation NSObject (LDNotification)

+ (NSString *)NOTIFICATION
{
    return [NSString stringWithFormat:@"notify.%@.", [self description]];
}

- (void)handleNotification:(NSNotification *)notification
{
    
}


- (void)observeNotification:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:name
                                               object:nil];
}

- (void)unobserveNotification:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
}

- (void)unobserveAllNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)postNotification:(NSString *)name
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"postNotification");
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
    });
}

- (void)postNotification:(NSString *)name withObject:(NSObject *)object
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
    });
}



@end
