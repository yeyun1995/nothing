//
//  LoginViewController.h
//  D-PET
//
//  Created by lk on 16/4/19.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *AuthCode;
@property (weak, nonatomic) IBOutlet UITextField *possWord;
@property (weak, nonatomic) IBOutlet UITextField *RepeatPassWord;
- (IBAction)Request:(id)sender;

- (IBAction)register:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *PassWordLable;

@property (weak, nonatomic) IBOutlet UIButton *request;

@end
