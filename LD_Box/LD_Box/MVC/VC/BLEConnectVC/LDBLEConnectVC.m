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

@interface LDBLEConnectVC () <UITableViewDataSource, UITableViewDelegate, LDBLEConnectVMDelegate>

@property (nonatomic, strong) LDBLEConnectVM *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *deviceTableView;

- (IBAction)refreshBtn:(UIButton *)sender;

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


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - property

- (LDBLEConnectVM *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    
    _viewModel = [[LDBLEConnectVM alloc] init];
    
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
    CBPeripheral *peripheral = deviceModel.peripheral;
    
    if(peripheral.state == CBPeripheralStateConnected) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"断开蓝牙连接?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else{
        [SVProgressHUD showWithStatus:@"正在连接"];
        
        
    }
}

#pragma mark - LDBLEConnectVMDelegate
- (void)foundPeripheralFinished {
    [self.deviceTableView reloadData];
}

#pragma mark - UIButton

- (IBAction)refreshBtn:(UIButton *)sender {
    
    [self.viewModel scanStart];
    
    
}
@end
