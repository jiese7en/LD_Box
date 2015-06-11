//
//  LDAlarmVC.m
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDAlarmListVC.h"
#import "LDAlarmListVM.h"
#import "LDAddAlarmVC.h"

@interface LDAlarmListVC () <LDAlarmListVMDelegate>

@property (nonatomic, strong) LDAlarmListVM *viewModel;

@end


@implementation LDAlarmListVC


#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"闹钟列表";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutTableView];
    
    [self.viewModel start];
}

- (void)layoutTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}


#pragma mark - property

- (LDAlarmListVM *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[LDAlarmListVM alloc] init];
    _viewModel.delegate = self;
    return _viewModel;
}

#pragma mark - LDAlarmListVMDelegate

#pragma mark - UIButton

- (IBAction)clickAddAlarm:(UIButton *)sender {
    
    LDAddAlarmVC *vc = [[LDAddAlarmVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
