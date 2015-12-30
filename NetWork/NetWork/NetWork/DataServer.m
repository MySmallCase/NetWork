//
//  DataServer.m
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "DataServer.h"

static id dataObj;

@implementation DataServer

/**
 *  @author yunFei, 16-12-30 16:12:14
 *
 *  post请求
 *
 *  @param url               URL地址
 *  @param params            请求参数
 *  @param modelClass        模型类
 *  @param responseDataBlock 返回的数据
 */
+ (void)postUrl:(NSString *)url params:(NSDictionary *)params modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock{
    
    [NetWorkRequest postRequest:url params:params success:^(id responseObj) {
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj,nil);
    } failure:^(NSError *error) {
        responseDataBlock(nil,error);
    }];
}

/**
 *  @author yunFei, 16-12-30 16:12:00
 *
 *  get请求
 *
 *  @param url               URL地址
 *  @param params            请求参数
 *  @param modelClass        模型类
 *  @param responseDataBlock 返回的数据
 */
+ (void)getUrl:(NSString *)url params:(NSDictionary *)params modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock{
    [NetWorkRequest getRequest:url params:params success:^(id responseObj) {
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj,nil);
    } failure:^(NSError *error) {
        responseDataBlock(nil,error);
    }];
}

+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass{
    return nil;
}



@end
