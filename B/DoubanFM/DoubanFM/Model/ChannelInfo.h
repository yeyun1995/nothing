//
//  ChannelInfo.h
//  DoubanFM
//
//  Created by lk on 16/5/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelInfo : NSObject
@property(nonatomic,copy)NSString* ID;
+(instancetype)currentChannel;
@end
