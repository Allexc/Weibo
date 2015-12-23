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

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    
    _tableView.tableHeaderView = headerView;
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self requestData];
}

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
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:sinaWeibo.userID forKey:@"uid"];
    
    [sinaWeibo requestWithURL:user_show params:params httpMethod:@"GET" delegate:self];
//    [NetworkService requestDataWithURL:user_show HTTPMethod:@"GET" params:nil completionHandle:^(id result, NSURLResponse *response, NSError *error) {
//        NSLog(@"%@",result);
//        NSLog(@"%@",response);
//    }];
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    NSLog(@"%@",result);
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    
    return cell;
}


@end
