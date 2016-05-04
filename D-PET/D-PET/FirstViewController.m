//
//  FirstViewController.m
//  D-PET
//
//  Created by lk on 16/4/17.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "FirstViewController.h"
#import "BounceButton.h"
#import "HSpringAnimation.h"
#define  POP_damoing 40
#define POP_stiffness 30
#define POP_mass 0
@interface FirstViewController ()
{
    UIView *sheetView;
    BounceButton *bounceButton;
    BOOL sheetOpen;
    UITextField *userName;
    UITextField *passWord ;
    
}
@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *BGImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    BGImageView.image = [UIImage imageNamed:@"18"];
    [self.view addSubview:BGImageView];
    
    sheetOpen=NO;
    sheetView=[[UIView alloc]initWithFrame:CGRectMake(25, 100, self.view.bounds.size.width-100, self.view.bounds.size.height-200)];
    sheetView.backgroundColor=[UIColor colorWithRed:0.235 green:0.961 blue:1.000 alpha:1.000];
    sheetView.layer.cornerRadius=50;
    sheetView.alpha=0.0f;
    UIImageView *sheetImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,sheetView.bounds.size.width,sheetView.bounds.size.height)];
    sheetImageView.image =[UIImage imageNamed:@"(GYW)RB0J]`MU4T6%9T[]3J"];
    [sheetView addSubview:sheetImageView];
    [self.view addSubview:sheetView];
    [self setAnchorPoint:CGPointMake(0.858, -0.1) forView:sheetView];
    
    userName=[[UITextField alloc]init];
    passWord=[[UITextField alloc]init];
    
    userName = [[UITextField alloc]initWithFrame:CGRectMake(sheetView.bounds.origin.x, sheetView.bounds.origin.y+10, 150, 30)];
    
    userName.placeholder=@"输入username";
    
    
    passWord = [[UITextField alloc]initWithFrame:CGRectMake(sheetView.frame.origin.x , sheetView.frame.origin.y+30, 150 , 30)];
    
    passWord.placeholder=@"输入密码";
   
    userName.delegate=self;
    passWord.delegate=self;
    
    NSArray *array = @[@"1",@"2",@"3"];
    UISegmentedControl *segmentedControl =[[UISegmentedControl alloc]initWithItems:array];
    segmentedControl.backgroundColor=[UIColor colorWithRed:0.140 green:0.880 blue:1.000 alpha:1.000];
    //[segmentedControl addTarget:self action:@selector() forControlEvents:UIControlEventValueChanged];
    
    
    
    [sheetView addSubview:userName];
    [sheetView addSubview:passWord];
    
    
    
}
-(void)returnBlack:(RETURNBLACK)black
{
    self.returnBlack=black;
}
-(void)viewDidDisappear:(BOOL)animated
{
    if (_returnBlack!=nil)
    {
        _returnBlack(userName.text);
        NSLog(@"有值");
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"TEXT:%@",userName.text);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:userName])
    {
        [userName resignFirstResponder];
    }
    else if([textField isEqual:passWord])
    {
        [passWord resignFirstResponder];
    }
    
    return YES;
}
-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView*)view
{
    CGPoint newpoint = CGPointMake(view.bounds.size.width *anchorPoint.x, view.bounds.size.height *anchorPoint.y);
    CGPoint oldpoint =CGPointMake(view.bounds.size.width *view.layer.anchorPoint.x, view.bounds.size.height *view.layer.anchorPoint.y);
    newpoint = CGPointApplyAffineTransform(newpoint, view.transform);
    oldpoint=CGPointApplyAffineTransform(oldpoint, view.transform);
    CGPoint position = view.layer.position;
    position.x -=oldpoint.x;
    position.x +=newpoint.x;
    position.y -=oldpoint.y;
    position.y +=newpoint.y;
    view.layer.position=position;
    view.layer.anchorPoint=anchorPoint;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button:(id)sender
{
    
    if (sheetOpen)
    {
        sheetOpen=NO;
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
        {
            sheetView.alpha=0.0f;
        } completion:NULL];
        HSpringAnimation *pop = [HSpringAnimation animationWithKeyPath:@"transform.scale"];
        
        pop.fromValue=@([[sheetView.layer valueForKey:@"transform.scale"]floatValue]);
        pop.toValue=@(0);
        [sheetView.layer addAnimation:pop forKey:@"transform.scale"];
        sheetView.transform = CGAffineTransformMakeScale(0, 0);
    }
    else
    {
        sheetOpen =YES;
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            sheetView.alpha=1.0f;
            
        } completion:NULL];
        HSpringAnimation *pop = [HSpringAnimation animationWithKeyPath:@"transform.scale"];
        pop.toValue=@(1.0);
        pop.fromValue=@([[sheetView.layer valueForKey:@"transform.scale"]floatValue]);
        [sheetView.layer addAnimation:pop forKey:@"transform,scale"];
        sheetView.transform=CGAffineTransformMakeScale(1.0, 1.0);
        
        
    }
}
@end
