//
//  ThirdViewController.m
//  D-PET
//
//  Created by lk on 16/4/17.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageViewB=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageViewB.image=[UIImage imageNamed:@"13"];
    [self.view addSubview:imageViewB];
    
    
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize=CGSizeMake(200, 200);
    
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    _collectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.allowsSelection=YES;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *Cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath ];
    Cell.backgroundColor =[UIColor colorWithRed:0.084 green:0.979 blue:1.000 alpha:1.000];
    return Cell;
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
