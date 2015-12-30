//
//  NetWorkRequest.h
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author yunFei, 16-12-30 15:12:22
 *  请求成功block
 */
typedef void (^requestSuccessBlock)(id responseObj);

/**
 *  @author yunFei, 16-12-30 15:12:42
 *  请求失败block
 */
typedef void (^requestFailureBlock)(NSError *error);


typedef void (^responseBlock)(id dataObj, NSError *error);


@interface NetWorkRequest : NSObject

/**
 *  @author yunFei, 16-12-30 15:12:45
 *
 *  post请求
 *
 *  @param url           地址
 *  @param params        参数
 *  @param successHandle 成功后返回数据信息
 *  @param failureHandle 失败后返回错误信息
 */
+ (void)postRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandle failure:(requestFailureBlock)failureHandle;

/**
 *  @author yunFei, 16-12-30 15:12:44
 *
 *  get请求
 *
 *  @param url           请求地址
 *  @param params        请求参数
 *  @param successHandle 成功后返回数据信息
 *  @param failureHandle 失败后返回错误信息
 */
+ (void)getRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandle failure:(requestFailureBlock)failureHandle;

@end
