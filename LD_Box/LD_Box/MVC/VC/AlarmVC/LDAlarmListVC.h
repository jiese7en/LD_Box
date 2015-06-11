//
//  LDAlarmVC.h
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBaseVC.h"

@interface LDAlarmListVC : LDBaseVC
@property (weak, nonatomic) IBOutlet UIButton *addAlarmBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)clickAddAlarm:(UIButton *)sender;

@end
