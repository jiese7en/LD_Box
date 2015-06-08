//
//  LDMusicLrcVC.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBaseVC.h"

@interface LDMusicLrcVC : LDBaseVC

@property (weak, nonatomic) IBOutlet UITableView *musicMemoTable;

@property (strong, nonatomic) NSMutableArray *itemListArr;

@property (assign, nonatomic) NSInteger lrcInt;

- (void)loadDataItemArr:(NSMutableArray *)itemListArr;
- (void)displaySongWord:(NSInteger)time;

@end
