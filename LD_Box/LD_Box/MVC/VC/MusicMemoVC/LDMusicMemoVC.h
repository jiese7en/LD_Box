//
//  LDMusicMemoVC.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBaseVC.h"

@interface LDMusicMemoVC : LDBaseVC
@property (weak, nonatomic) IBOutlet UILabel *musicMemoLabel;

- (void)setMusicInfo:(NSString*)strInfo;

@end
