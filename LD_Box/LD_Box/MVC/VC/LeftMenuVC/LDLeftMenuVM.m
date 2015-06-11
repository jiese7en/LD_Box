//
//  LDLeftMenuVM.m
//  LD_Box
//
//  Created by Jay on 15/6/2.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDLeftMenuVM.h"

@implementation LDLeftMenuVM




#pragma mark - property

- (NSArray *)titleArr {
    if (_titleArr) {
        return _titleArr;
    }
    
    _titleArr = [NSArray arrayWithObjects:@"主页:",@"蓝牙推送:",@"蓝牙连接:",@"卡歌曲播放:",@"U盘歌曲播放",@"收音机:",@"闹钟:",@"音频输入:",@"卡录音回放",@"U盘录音回放", nil];
    
    return _titleArr;
}

@end
