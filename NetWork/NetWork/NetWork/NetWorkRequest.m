//
//  NetWorkRequest.m
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "NetWorkRequest.h"
#import <AFNetworking.h>

static const NSString *baseUrl = @"https://api.cellmyth.cn/app";

@implementation NetWorkRequest

/**
 *  @author yunFei, 16-12-30 15:12:28
 *  post 请求
 */
+ (void)postRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandle failure:(requestFailureBlock)failureHandle{
    if (![self checkNetworkStatue]) {
        successHandle(nil);
        failureHandle(nil);
        return;
    }
    
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",baseUrl,url];
    
    AFHTTPSessionManager *manager = [self getManager];
    [manager POST:postUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandle(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandle(error);
    }];
    
}

+ (void)getRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandle failure:(requestFailureBlock)failureHandle{
    if (![self checkNetworkStatue]) {
        successHandle(nil);
        failureHandle(nil);
        return;
    }
    
    NSString *getUrl = [NSString stringWithFormat:@"%@%@",baseUrl,url];
    
    AFHTTPSessionManager *manager = [self getManager];
    [manager GET:getUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandle(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandle(error);
    }];
    
}

+ (AFHTTPSessionManager *)getManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manager.securityPolicy = securityPolicy;
    manager.requestSerializer.timeoutInterval = 10.0f;
    
    return manager;
}


/**
 *  @author yunFei, 16-12-30 15:12:26
 *  监控网络状态
 */
+ (BOOL)checkNetworkStatue{
    __block BOOL isNetworkStatue = YES;
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            isNetworkStatue = YES;
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            isNetworkStatue = YES;
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            isNetworkStatue = YES;
        }else if (status == AFNetworkReachabilityStatusNotReachable){
            isNetworkStatue = NO;
        }
    }];
    [manager startMonitoring];
    return isNetworkStatue;
    
}

@end
