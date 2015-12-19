//
//  WeiboDetailTableView.h
//  MyWeibo
//
//  Created by Allen on 15/12/14.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboFrameModel.h"
#import "WeiboModel.h"
@interface WeiboDetailTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) WeiboFrameModel *weiboFrameModel;
@property(nonatomic,strong) WeiboModel *weiboModel;

@property(nonatomic, copy) NSArray *commentArray;
@property(nonatomic, copy) NSString *commentCount;
- (CGFloat)getCellHeight:(NSInteger)row ;
@end
