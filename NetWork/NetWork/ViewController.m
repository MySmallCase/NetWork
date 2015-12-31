//
//  ViewController.m
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ViewController.h"
#import "viewModel.h"


@interface ViewController ()

@property (nonatomic,strong) viewModel *model;


@property (nonatomic,strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    /demo/aaa
    
//    viewModel *model = [[viewModel alloc] initWithGetUserInfo];
//    NSString *str = [model getUserInfo];
    
    [self.view addSubview:self.label];
    
    
    [viewModel getUserInfoData:^(id obj) {
        
        if (obj == nil) {
            self.label.text = @"参数错误";
        }else{
            self.label.text = obj;
        }
        
        
    }];
    
    
    
}


- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
        _label.backgroundColor = [UIColor blueColor];
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:14.0f];
//        _label.text = @"测试";
    }
    return _label;
}


@end
