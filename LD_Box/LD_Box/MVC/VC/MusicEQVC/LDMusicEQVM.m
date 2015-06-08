//
//  LDMusicEQVM.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMusicEQVM.h"

@implementation LDMusicEQVM

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - property

- (NSArray *)eqItemsArr {
    if (_eqItemsArr) {
        return _eqItemsArr;
    }
    _eqItemsArr = [[NSArray alloc] initWithObjects:@"爵士",@"流行",@"经典",@"柔和",@"重低音",@"摇滚",@"用户音效", nil];
    return _eqItemsArr;
}


@end
