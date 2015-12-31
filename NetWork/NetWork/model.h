//
//  model.h
//  NetWork
//
//  Created by MyMac on 15/12/30.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Data;
@interface baseModel : NSObject




@property (nonatomic, copy) NSString *error;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) Data *data;


@end

@interface Data : NSObject

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *age;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *nickname;

@end

