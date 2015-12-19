//
//  LeftViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "LeftViewController.h"
#import "Common.h"
#import "ThemeImgView.h"
@interface LeftViewController ()
{
    NSArray *_titleArray;
    NSArray *_otherArray;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    _titleArray = @[@"无",@"偏移",@"偏移&缩放",@"旋转",@"视差"];
    _otherArray = @[@"小图",@"大图"];
    
    UITableView *_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
       
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 40)];
        label.text = @"界面切换效果";
        label.font = [UIFont boldSystemFontOfSize:18];
        [view addSubview:label];
        return view ;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
    label.text = @"图片浏览模式";
    label.font = [UIFont boldSystemFontOfSize:18];
    [view addSubview:label];
    return view ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 20)];
    if (indexPath.section == 0) {
        label.text = _titleArray[indexPath.row];
            }else if (indexPath.section == 1) {
        label.text = _otherArray[indexPath.row];
    }
    [cell addSubview:label];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentLeft;

    return cell;
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
