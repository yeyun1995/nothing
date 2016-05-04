//
//  SecondViewController.m
//  D-PET
//
//  Created by lk on 16/4/17.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FirstViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageViewB=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageViewB.image=[UIImage imageNamed:@"6-1"];
    [self.view addSubview:imageViewB];
    NSArray *controllers = [self.tabBarController viewControllers];
    for (int i = 0; i<[controllers count]; i++)
    {
        if ([[controllers objectAtIndex:i]isMemberOfClass:[ThirdViewController class]])
        {
            
        }
        else if([[controllers objectAtIndex:i]isMemberOfClass:[FirstViewController class]])
        {
            FirstViewController *firC = [controllers objectAtIndex:i];
            [firC returnBlack:^(NSString *showBlack)
            {
                _labelone.text=showBlack;
                NSLog(@"ahdba");
            }];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
