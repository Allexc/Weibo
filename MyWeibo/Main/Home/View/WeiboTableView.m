//
//  WeiboTableView.m
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboTableViewCell.h"
#import "WeiboFrameModel.h"
#import "UIView+UIViewController.h"
#import "HomeDetailController.h"
@implementation WeiboTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        
        UINib *nib = [UINib nibWithNibName:@"WeiboTableViewCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:@"weibocell"];
       
        
    
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.dataSource = self;
        self.delegate = self;
        
        UINib *nib = [UINib nibWithNibName:@"WeiboTableViewCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:@"weibocell"];
        
        

    }
    return self;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboFrameModel *frameModel = _dataArray[indexPath.row];
    CGFloat x = frameModel.frame.size.height + 90;
    return x;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeiboTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weibocell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.frameModel = _dataArray[indexPath.row];
    return cell;
    
    
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *vc = self.viewController;
    HomeDetailController *hVc = [[HomeDetailController alloc]init];
    hVc.title = @"微博详情";
    hVc.weiboFrameModel = _dataArray[indexPath.row];

    [vc.navigationController pushViewController:hVc animated:YES];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
