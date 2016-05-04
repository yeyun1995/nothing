//
//  LoginViewController.m
//  D-PET
//
//  Created by lk on 16/4/19.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "LoginViewController.h"
#import <MOBFoundation/MOBFoundation.h>
#import <SMS_SDK/SMSSDK.h>
#import <FMDB/FMDatabase.h>
#define TIMER 60
@interface LoginViewController ()
{
    NSString *phoneNumberStr;
    NSString *AuthCodeStr;
     NSString *PasswordStr; 
    NSString *repeatPassWordStr;
    NSTimer *timer;
    NSInteger timerCount;
    NSString *dataBase;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _phoneNumber.delegate=self;
    _possWord.delegate=self;
    _AuthCode.delegate=self;
    _RepeatPassWord.delegate=self;
    
    [_request addTarget:self action:@selector(nothing) forControlEvents:UIControlEventTouchUpInside];
    
     _request.hidden=YES;
    
    _PassWordLable.alpha=0.0f;
    
    dataBase=@"/Users/lk/Desktop/noting/FMDB/MydataBaseD_PET.db";
    
    UIImageView *imageViewB=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageViewB.image=[UIImage imageNamed:@"6-1"];
    [self.view addSubview:imageViewB];
    
}
-(void)nothing
{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumberStr zone:@"86" customIdentifier:nil result:^(NSError *error)
     {
         if (error)
         {
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入正确的手机号码" preferredStyle: UIAlertControllerStyleActionSheet ];
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 
             }];
             [alert addAction:action];
             [self presentViewController:alert animated:YES completion:^{
                 NSLog(@"结束对话框");
             }];
         }
         else
         {
             NSLog(@"success");
         }
         
         
     }];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_phoneNumber])
    {
        phoneNumberStr=_phoneNumber.text;
    }
    else if([textField isEqual:_AuthCode])
    {
        AuthCodeStr=_AuthCode.text;
    }
    else if([textField isEqual:_possWord])
    {
        PasswordStr=_possWord.text;
    }else if([textField isEqual:_RepeatPassWord])
    {
        repeatPassWordStr=_RepeatPassWord.text;
        
           }
        [textField resignFirstResponder];
   
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if ([textField isEqual:_phoneNumber])
//    {
//        phoneNumberStr=_phoneNumber.text;
//    }
//    else if([textField isEqual:_AuthCode])
//    {
//        AuthCodeStr=_AuthCode.text;
//    }
//    else if([textField isEqual:_possWord])
//    {
//        PasswordStr=_possWord.text;
//    }else if([textField isEqual:_RepeatPassWord])
//    {
//        repeatPassWordStr=_RepeatPassWord.text;
//        
//    }
//    [textField resignFirstResponder];
//    return YES;
//}
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    if ([textField isDescendantOfView:_phoneNumber])
//    {
//        phoneNumberStr=_phoneNumber.text;
//    }
//    else if([textField isDescendantOfView:_AuthCode])
//    {
//        AuthCodeStr=_AuthCode.text;
//    }
//    else if([textField isDescendantOfView:_possWord])
//    {
//        NSLog(@"ada");
//        PasswordStr=_possWord.text;
//    }else if([textField isDescendantOfView:_RepeatPassWord])
//    {
//        
//        if ([PasswordStr isEqualToString:_RepeatPassWord.text])
//        {
//            _PassWordLable.alpha=0.0f;
//        }
//        else
//        {
//            _PassWordLable.alpha=1.0f;
//        }
//    }
//    [textField resignFirstResponder];
//    
//    return YES;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Request:(id)sender
{
   // NSLog(@"%@",PasswordStr);
    [_phoneNumber resignFirstResponder];
    NSLog(@"%@",phoneNumberStr);
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumberStr zone:@"86" customIdentifier:nil result:^(NSError *error)
     {
         if (error)
         {
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入正确的手机号码" preferredStyle: UIAlertControllerStyleActionSheet ];
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 
             }];
             [alert addAction:action];
             [self presentViewController:alert animated:YES completion:^
             {
                 NSLog(@"结束对话框");
             }];
         }
         else
         {
             NSLog(@"success");
         }
    }];
    timerCount=TIMER;
    _request.hidden=NO;
    _request.titleLabel.text=[NSString stringWithFormat:@"%lu",timerCount];
    timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(change) userInfo:nil repeats:YES];
   
}
-(void)change
{
     timerCount--;
    _request.hidden=NO;
    _request.titleLabel.text=[NSString stringWithFormat:@"%lu",timerCount];
    if (timerCount<=0)
    {
        _request.titleLabel.text=@"重新发送";
        _request.hidden=NO;
        [timer invalidate];
    }
    
}


- (IBAction)register:(id)sender
{
//    _Bool isPointerEqual = PasswordStr == repeatPassWordStr;
//    NSLog(@"%@",isPointerEqual);
    [_RepeatPassWord resignFirstResponder];
    if(PasswordStr == repeatPassWordStr)
    {
       // NSLog(@"%@ %@",PasswordStr,repeatPassWordStr);
        _PassWordLable.alpha=0.0f;
    }else
    {
        //NSLog(@"显示");
         NSLog(@"%@ %@",PasswordStr,repeatPassWordStr);
        _PassWordLable.alpha=1.0f;
    }
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumberStr zone:@"86" customIdentifier:nil result:^(NSError *error)
     {
         if (error)
         {
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入正确的手机号码" preferredStyle: UIAlertControllerStyleActionSheet ];
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
             }];
             [alert addAction:action];
             [self presentViewController:alert animated:YES completion:^{
                 NSLog(@"结束对话框");
             }];
         }
         else
         {
             NSFileManager *manger = [NSFileManager defaultManager];
             if([manger fileExistsAtPath:dataBase]==NO)
             {
                 NSLog(@"%@",dataBase);
                 FMDatabase *db=[FMDatabase databaseWithPath:dataBase];
                // FMDatabase *db=[FMDatabase databaseWithPath:dataBase];
                 if([db open])
                 {
                     NSString *sql = @"CREATE TABLE 'User'('id'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'name'VARCHAR(30),'password'VARCHAR(30))";
                     BOOL res =[db executeUpdate:sql];
                     if(res)
                     {
                         NSString* sqlinster = @" insert into user(name,password)values(?,?)";
                         BOOL resinster = [db executeUpdate:sqlinster,phoneNumberStr,PasswordStr];
                         if(resinster)
                         {
                             NSLog(@"inster");
                         }
                         else
                         {
                             NSLog(@"inster fail");
                         }
                         
                     }
                     [db close];
                 }
                 else
                 {
                     NSLog(@"db no open");
                 }
             }
             else
             {
                 NSLog(@"no find db");
             }
             //NSLog(@"success");
         }
     }];

     NSLog(@"ad22a");
}
@end
