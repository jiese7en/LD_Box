//
//  LDMusicBoxVC.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBaseVC.h"
#import "LDMusicBeanModel.h"
#import "LDMusicMemoVC.h"
#import "LDMusicLrcVC.h"

@interface LDMusicBoxVC : LDBaseVC


@property(nonatomic,strong) LDMusicBeanModel *musicBeanModel;

@property(nonatomic,strong) NSMutableArray *CBLPLMusicArr;
@property(nonatomic,strong) NSMutableArray *tempArr;
@property(nonatomic,strong) NSMutableArray *itemArr;

@property(nonatomic,strong) LDMusicMemoVC *musicMemoVC;
@property(nonatomic,strong) LDMusicLrcVC *musicLrcVC;

@end
