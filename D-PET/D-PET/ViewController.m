//
//  ViewController.m
//  D-PET
//
//  Created by lk on 16/4/15.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "ViewController.h"
#import <FMDB/FMDatabase.h>
#import "TabBarViewController.h"
#import "FirstViewController.h"
#define imageCount 9
#define scrollViewSize (self.scrollView.frame.size)

@interface ViewController ()
{
    NSString *dataBase;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadScrollView];
    [self loadPageControl];
    [self loadTime];
    dataBase=@"/Users/lk/Desktop/noting/FMDB/DataBase.db";
    _pageControl.frame=CGRectMake(0, 100, 200, 237);
    _UserName.delegate=self;
    _PassWord.delegate=self;
    
    UIImageView *imageViewB=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageViewB.image=[UIImage imageNamed:@"8-1"];
    [self.view addSubview:imageViewB];
    
   
 
}
-(void)loadScrollView
{
    for (int i =0; i<imageCount; i++)
    {
        CGFloat imageViewX= i *scrollViewSize.width;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, 0, scrollViewSize.width, scrollViewSize.height)];
        NSString *imageName = [NSString stringWithFormat:@"%d",i];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }
    CGFloat imageViewW=imageCount *scrollViewSize.width;
    self.scrollView.contentSize=CGSizeMake(imageViewW,0);
    self.scrollView.pagingEnabled=YES;
    self.scrollView.delegate=self;
}
-(void)loadPageControl
{
    self.pageControl.numberOfPages=imageCount;
    self.pageControl.currentPage=0;
    self.pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    self.pageControl.pageIndicatorTintColor=[UIColor greenColor];
}
-(void)loadTime
{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(pageChanged:) userInfo:nil repeats:YES];
    NSRunLoop *mainLoop = [NSRunLoop mainRunLoop];
    [mainLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
-(void)pageChanged:(id)sender
{
    NSInteger currenPage =self.pageControl.currentPage;
    CGPoint offset = self.scrollView.contentOffset;
    if (currenPage>=imageCount-1)
    {
        currenPage=0;
        offset.x=0;
    }
    else
    {
        currenPage++;
        offset.x+=scrollViewSize.width;
    }
    self.pageControl.currentPage=currenPage;
    [self.scrollView setContentOffset:offset animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset =scrollView.contentOffset;
    NSInteger currenPage = offset.x /scrollViewSize.width;
    NSLog(@"%ld",(long)currenPage);
    self.pageControl.currentPage=currenPage;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self loadTime];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButton:(id)sender
{
    [_PassWord resignFirstResponder];
    [_UserName resignFirstResponder];
    NSLog(@"%@",_UserName.text);
    NSLog(@"%@",_PassWord.text);
    FMDatabase *db = [FMDatabase databaseWithPath:dataBase];
    if ([db open])
    {
        NSString *sql=@"select * from user where name = '2'";
        BOOL res =[db executeQuery:sql];
        if (res)
        {
           
            TabBarViewController *tabbarC =[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
            tabbarC.navigationItem.hidesBackButton=YES;
            [self.navigationController pushViewController:tabbarC animated:YES];
          // self presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>
//            [self.navigationController pushViewController:firC animated:YES];
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"prompt" message:@"用户名或密码不对" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"I know" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
    }
    else
    {
        NSLog(@"db no open");
    }
}
@end
