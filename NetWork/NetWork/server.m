//
//  server.m
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "server.h"
#import "model.h"

#import <MJExtension.h>

@implementation server

+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass{

    model *m = [modelClass mj_objectWithKeyValues:responseObj];
    return m.error;
    
}

@end
