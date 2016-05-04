//
//  NetworkManager.h
//  DoubanFM
//
//  Created by lk on 16/5/3.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolClass.h"
@interface NetworkManager : NSObject
@property(weak,nonatomic)id<DoubanDelegate>delegate;
+(instancetype)sharefInstancd;
-(instancetype)init;

-(void)loadPlayListWithtype:(NSString *)type;
@end
