//
//  LeftMenuVC.m
//  LD_Box
//
//  Created by Jay on 15/5/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDLeftMenuVC.h"
#import "LDLeftMenuVM.h"

//MMDrawer
#import "UIViewController+MMDrawerController.h"

//VC
#import "LDBaseNC.h"
#import "LDBLEConnectVC.h"
#import "LDMusicVC.h"
#import "LDMainVC.h"

@interface LDLeftMenuVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (nonatomic, strong) LDLeftMenuVM *viewModel;

@end

@implementation LDLeftMenuVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"LeftMenu";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - property

- (LDLeftMenuVM *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    
    _viewModel = [[LDLeftMenuVM alloc] init];
    
    return _viewModel;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"leftMenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSString *text = [self.viewModel.titleArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = text;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        LDMainVC *vc = [LDMainVC sharedInstance];
        LDBaseNC *nc = [[LDBaseNC alloc] initWithRootViewController:vc];
        [self.mm_drawerController setCenterViewController:nc withCloseAnimation:YES completion:^(BOOL finished) {}];
    }
    else if (indexPath.row == 1) {
        LDMusicVC *vc = [LDMusicVC sharedInstance];
        LDBaseNC *nc = [[LDBaseNC alloc] initWithRootViewController:vc];
        [self.mm_drawerController setCenterViewController:nc withCloseAnimation:YES completion:^(BOOL finished) {}];
    }
    else if (indexPath.row == 2) {
        LDBLEConnectVC *vc = [LDBLEConnectVC sharedInstance];
        LDBaseNC *nc = [[LDBaseNC alloc] initWithRootViewController:vc];
        [self.mm_drawerController setCenterViewController:nc withCloseAnimation:YES completion:^(BOOL finished) {}];
    }
}

@end
