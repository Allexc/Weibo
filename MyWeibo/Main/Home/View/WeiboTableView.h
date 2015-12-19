//
//  WeiboTableView.h
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy)NSArray *dataArray;
@end
