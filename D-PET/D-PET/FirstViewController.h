//
//  FirstViewController.h
//  D-PET
//
//  Created by lk on 16/4/17.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RETURNBLACK)(NSString*showBlack);
@interface FirstViewController : UIViewController<UITextFieldDelegate>
- (IBAction)button:(id)sender;
@property(nonatomic,copy)RETURNBLACK returnBlack;
-(void)returnBlack:(RETURNBLACK)black;
@end
