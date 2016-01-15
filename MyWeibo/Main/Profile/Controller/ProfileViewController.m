//
//  ProfileViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCell.h"
#import "HeaderView.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "Common.h"
#import "NetworkService.h"
@interface ProfileViewController ()
{
    NSMutableArray *_weiboArray;
    HeaderView *_headerView;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headerView = [[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    
    _tableView.tableHeaderView = _headerView;
    [self requestData];
    

}

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - requestData

- (void)requestData {
    
//    [NetworkService requestAFUrl:user_show httpMethod:@"GET" params:nil data:nil block:^(id result, NSURLResponse *response, NSError *error) {
//        NSLog(@"resule==%@",result);
//    }];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:sinaWeibo.userID forKey:@"uid"];
    
    [sinaWeibo requestWithURL:user_timeline params:nil httpMethod:@"GET" delegate:self];
//    [NetworkService requestDataWithURL:user_show HTTPMethod:@"GET" params:nil completionHandle:^(id result, NSURLResponse *response, NSError *error) {
//        NSLog(@"%@",result);
//        NSLog(@"%@",response);
//    }];
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    NSLog(@"%@",result);
    NSArray *resultArray = [result objectForKey:@"statuses"];
    _weiboArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    for (NSDictionary *dic in resultArray) {
        WeiboModel *weiboModel = [[WeiboModel alloc]initWithDataDic:dic];
        [_weiboArray addObject:weiboModel];
        
    }
    WeiboModel *weiboModel = [_weiboArray lastObject];
    NSLog(@"weiboaray==%@",_weiboArray);
    _headerView.userModel = weiboModel.userModel;
    _headerView.total_number = [[result objectForKey:@"total_number"] integerValue];
    [_tableView reloadData];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    cell.weiboModel = _weiboArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = [ProfileCell getRowHeight:_weiboArray[indexPath.row]];
    
    return h+80;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 30;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
//    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, kScreenWidth-30, 30)];
//    lable.text = @"共有200条微博";
//    [view addSubview:lable];
//    
//    return view;
//}
@end
