//
//  viewModel.m
//  NetWork
//
//  Created by MyMac on 15/12/31.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "viewModel.h"
#import "server.h"

@implementation viewModel

+ (void)getUserInfoData:(dataBlock)obj{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"key"] = @"C";
    [server postUrl:@"/index.aspx" params:dict modelClass:[baseModel class] responseBlock:^(id dataObj, NSError *error) {
        if ([dataObj isKindOfClass:[Data class]]) {
            Data *d = [Data mj_objectWithKeyValues:dataObj];
            obj(d.nickname);
        }else{
            obj(nil);
        }
    }];
}

@end
