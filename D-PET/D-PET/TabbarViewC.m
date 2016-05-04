//
//  TabbarViewC.m
//  D-PET
//
//  Created by lk on 16/4/26.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "TabbarViewC.h"
#import <RESideMenu.h>
@interface TabbarViewC ()<UITabBarDelegate,UINavigationBarDelegate>

@end
@implementation TabbarViewC
-(void)viewDidLoad
{
    [super viewDidLoad];
    UIStoryboard *MainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *MainNAV = [MainSB instantiateViewControllerWithIdentifier:@"FIR_PersonalData"];
    self.tabBar.translucent=NO;
    self.viewControllers=@[MainNAV];
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
