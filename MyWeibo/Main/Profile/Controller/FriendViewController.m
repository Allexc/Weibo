//
//  FriendViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/23.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "FriendViewController.h"
#import "FriendCollectionView.h"
#import "Common.h"
@interface FriendViewController ()

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注列表";
    self.view .backgroundColor = [UIColor orangeColor];
  
    FriendCollectionView *collection = [[FriendCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    collection.pagingEnabled = YES;
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
