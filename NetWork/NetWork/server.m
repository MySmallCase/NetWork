//
//  server.m
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "server.h"




@implementation server

+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass{

    
    baseModel *m = [modelClass mj_objectWithKeyValues:responseObj];
    if (![m.error isEqualToString:@"0"]) {
        return m.message;
    }else{
        return m.data;
    }
        
    
    
}

@end
