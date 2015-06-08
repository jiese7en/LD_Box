//
//  LDMusicBoxVC.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMusicBoxVC.h"

@interface LDMusicBoxVC ()

@end

@implementation LDMusicBoxVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - property

- (LDMusicBeanModel *)musicBeanModel {
    if (_musicBeanModel) {
        return _musicBeanModel;
    }
    _musicBeanModel = [[LDMusicBeanModel alloc] init];
    return _musicBeanModel;
}

- (NSMutableArray *)CBLPLMusicArr {
    if (_CBLPLMusicArr) {
        return _CBLPLMusicArr;
    }
    _CBLPLMusicArr = [NSMutableArray array];
    return _CBLPLMusicArr;
}

- (NSMutableArray *)tempArr {
    if (_tempArr) {
        return _tempArr;
    }
    _tempArr = [NSMutableArray array];
    return _tempArr;
}


- (NSMutableArray *)itemArr {
    if (_itemArr) {
        return _itemArr;
    }
    _itemArr = [NSMutableArray array];
    return _itemArr;
}

- (LDMusicMemoVC *)musicMemoVC {
    if (_musicMemoVC) {
        return _musicMemoVC;
    }
    _musicMemoVC = [[LDMusicMemoVC alloc] init];
    return _musicMemoVC;
}

- (LDMusicLrcVC *)musicLrcVC {
    if (_musicLrcVC) {
        return _musicLrcVC;
    }
    _musicLrcVC = [[LDMusicLrcVC alloc] init];
    return _musicLrcVC;
}


@end
