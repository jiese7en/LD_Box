//
//  LDMusicLrcVC.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMusicLrcVC.h"
#import "UIColor+LDColor.h"
#import "UIFont+LDFont.h"

@interface LDMusicLrcVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation LDMusicLrcVC

#pragma mark - Init

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Private Methods

- (void)updateLrcTableView:(NSUInteger)lineNumber {
    //重新载入 歌词列表lrcTabView
    self.lrcInt = lineNumber;
    [self.musicMemoTable reloadData];
    
    //使被选中的行移到中间
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lineNumber inSection:0];
    [self.musicMemoTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}

#pragma mark - Methods

- (void)loadDataItemArr:(NSMutableArray *)itemListArr {
    self.itemListArr = itemListArr;
    [self.musicMemoTable reloadData];
}

- (void)displaySongWord:(NSInteger)time {
    
    for (int i = 0; i < [self.itemListArr count]; i++) {
        NSDictionary *dic = [self.itemListArr objectAtIndex:i];
        NSString *key = @"key is nil";
        
        if (dic) {
            key = [dic.allKeys objectAtIndex:0];
            float fKey = key.floatValue;
            float fCur = time/1000;
            
            if (i == self.itemListArr.count - 1) {
                if (fCur > fKey) {
                    [self updateLrcTableView:i];
                    break;
                }
            }
            else {
                //求出第一句的时间点，在第一句显示前的时间内一直加载第一句
                NSDictionary *dic0 = [self.itemListArr objectAtIndex:0];
                NSString *key0 = @"key is nil";
                
                key0 = [dic0.allKeys objectAtIndex:0];
                float fKey0 = key0.floatValue;
                if (fCur < fKey0) {
                    [self updateLrcTableView:0];
                    //                NSLog(@"马上到第一句");
                    break;
                }
                //求出下一步的歌词时间点，然后计算区间
                NSDictionary *dic1 = [self.itemListArr objectAtIndex:i+1];
                NSString *key1 = @"key is nil";
                
                key1 = [dic1.allKeys objectAtIndex:0];
                float fKey1 = key1.floatValue;
                if (fCur >= fKey && fCur <= fKey1) {
                    [self updateLrcTableView:i];
                    break;
                }
                
            }
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"musicMemoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //该表格选中后没有颜色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    NSDictionary *dic = [self.itemListArr objectAtIndex:indexPath.row];
    
    NSString *key = @"key is nil";
    NSString *value = @"value is nil";
    if (dic) {
        key = [dic.allKeys objectAtIndex:0];
        value = [dic objectForKey:key];
        
        cell.textLabel.text = value;
    }
    
    if (indexPath.row == self.lrcInt) {
        cell.textLabel.textColor = RGBAlpha(255, 255, 255, 1);
        cell.textLabel.font = LD_FONT(15);
    } else {
        cell.textLabel.textColor = RGBAlpha(255, 255, 255, 0.5);
        cell.textLabel.font = LD_FONT(13);
    }
    return cell;
}

#pragma mark - UITableViewDelegate

@end
