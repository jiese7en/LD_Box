//
//  LDBLEConnectVC.m
//  LD_Box
//
//  Created by Jay on 15/6/2.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBLEConnectVC.h"
#import "LDBLEConnectVM.h"
#import "LDBluzDeviceModel.h"
#import "SVProgressHUD.h"

@interface LDBLEConnectVC () <UITableViewDataSource, UITableViewDelegate, LDBLEConnectVMDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) LDBLEConnectVM *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *deviceTableView;

@end

@implementation LDBLEConnectVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"蓝牙连接";
    }
    return self;
}


//单例
+ (LDBLEConnectVC *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static LDBLEConnectVC * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutTableView];
    
    [self layoutRightItem];
    
    [self.viewModel start];
}

- (void)layoutTableView {
    self.deviceTableView.tableFooterView = [[UIView alloc] init];
}


- (void)layoutRightItem {
    
    UIButton *refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [refreshBtn setImage:[UIImage imageNamed:@"ic_menu_refresh"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(clickRefreshBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    
    
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - property

- (LDBLEConnectVM *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    
    _viewModel = [[LDBLEConnectVM alloc] init];
    _viewModel.delegate = self;
    return _viewModel;
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.deviceArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"leftMenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    LDBluzDeviceModel *deviceModel = [self.viewModel.deviceArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = deviceModel.deviceName;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LDBluzDeviceModel *deviceModel = [self.viewModel.deviceArr objectAtIndex:indexPath.row];
    
    if([deviceModel isConnected]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"断开蓝牙连接?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else{
        [SVProgressHUD showWithStatus:@"正在连接"];
        
        [self.viewModel connect:deviceModel];
    }
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.viewModel disconnect];
    }
}


#pragma mark - LDBLEConnectVMDelegate
- (void)foundPeripheralFinished {
    
    [SVProgressHUD dismiss];
    
    [self.deviceTableView reloadData];
}

- (void)connectedPeripheralFinished {
    [SVProgressHUD dismiss];
    
}

- (void)disconnectedPeripheralFinished {
    [SVProgressHUD dismiss];
}

- (void)disconnectedPeripheralFinished:(BOOL)onInitiative {
    [SVProgressHUD dismiss];
}


#pragma mark - UIButton

- (void)clickRefreshBtn:(UIButton *)sender {
    
    [SVProgressHUD showWithStatus:@"正在搜索设备"];
    [self.viewModel scanStart];
}
@end
