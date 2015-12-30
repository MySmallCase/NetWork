//
//  DataServer.h
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkRequest.h"


@interface DataServer : NSObject

+ (void)postUrl:(NSString *)url params:(NSDictionary *)params modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;

+ (void)getUrl:(NSString *)url params:(NSDictionary *)params modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;

/**
 数组、字典转模型，提供给子类的接口
 */
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass;

@end
