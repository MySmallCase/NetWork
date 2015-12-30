//
//  NetWorkRequest.m
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "NetWorkRequest.h"
#import <AFNetworking.h>

#import <sys/sysctl.h>

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
    
    NSMutableDictionary *param = [self dictionaryWithParams:params];
    
    NSLog(@"%@",param);
    
    AFHTTPSessionManager *manager = [self getManager];
    [manager POST:postUrl parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
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

+ (NSMutableDictionary *)dictionaryWithParams:(NSDictionary *)params{
    
    
    UIDevice *currentDevice = [UIDevice currentDevice];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    //系统类型
    param[@"system"] = @"iOS";
    //系统版本号
    param[@"system_version"] = [NSString stringWithFormat:@"%@",currentDevice.systemVersion];
    //应用名称
    param[@"app_name"] = @"daiyanwang";
    //应用版本
    param[@"app_version"] = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //应用平台
    param[@"platform"] = [NSString stringWithFormat:@"%@",UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? @"iPhone" : @"iPad"];
    //客户端时间，时间戳，单位秒
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYYMMddhhmmssSS";
    NSString *dateString = [formatter stringFromDate:currentDate];
    param[@"datetime"] = dateString;
    
    //设备名称
//    param[@"device_name"] = currentDevice.model;
    param[@"device_name"] = [self deviceType];
    
    //设备唯一标识UUID
    param[@"device_id"] = currentDevice.identifierForVendor.UUIDString;
    
    //设备分辨率
    param[@"resolution"] = [NSString stringWithFormat:@"%.0f*%.0f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height];
    
    return param;
    
}


+ (NSString *)getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    NSString *result = [NSString stringWithCString:answer
                                          encoding:NSUTF8StringEncoding];
    free(answer);
    return result;
}

#pragma mark - platform information

/**
 *  平台信息
 */
+ (NSString *)platform
{
    return [self getSysInfoByName:"hw.machine"];
}

/**
 *  设备型号
 */
+ (NSString *)deviceType
{
    NSString *platform = [self platform];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (CDMA)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (CDMA)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (CDMA)";
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}


@end
