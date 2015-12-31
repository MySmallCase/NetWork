//
//  viewModel.h
//  NetWork
//
//  Created by MyMac on 15/12/31.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^dataBlock)(id obj);

@interface viewModel : NSObject

+ (void)getUserInfoData:(dataBlock)obj;

@end
