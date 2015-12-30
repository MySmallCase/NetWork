//
//  ViewController.m
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ViewController.h"
#import "server.h"
#import "model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"id"] = @"1";
    [server postUrl:@"/demo/aaa" params:dict modelClass:[model class] responseBlock:^(id dataObj, NSError *error) {
        NSLog(@"%@==",dataObj);
    }];
    
    
}


@end
