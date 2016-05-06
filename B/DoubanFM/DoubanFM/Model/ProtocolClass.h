//
//  ProtocolClass.h
//  DoubanFM
//
//  Created by lk on 16/5/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DoubanDelegate <NSObject>
-(void)reloadTableViewData;
-(void)initSongInformation;



@end
@interface ProtocolClass : NSObject

@end
