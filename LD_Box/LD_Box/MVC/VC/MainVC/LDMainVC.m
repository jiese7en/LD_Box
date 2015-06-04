//
//  LDMainVC.m
//  LD_Box
//
//  Created by Jay on 15/5/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMainVC.h"

@interface LDMainVC ()

@end

@implementation LDMainVC


#pragma mark - Init

//单例
+ (LDMainVC *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static LDMainVC * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Main";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
