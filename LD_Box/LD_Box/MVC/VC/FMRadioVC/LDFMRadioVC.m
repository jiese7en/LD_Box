//
//  LDFMRadioVC.m
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDFMRadioVC.h"
#import "LDFMRadioVM.h"

@interface LDFMRadioVC () <LDFMRadioVMDelegate>


@property (nonatomic, strong) LDFMRadioVM *viewModel;

@end


@implementation LDFMRadioVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"收音机";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel start];
}

#pragma mark - property

- (LDFMRadioVM *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[LDFMRadioVM alloc] init];
    _viewModel.delegate = self;
    return _viewModel;
}

#pragma mark - LDFMRadioVMDelegate


@end
