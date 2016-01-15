//
//  ProfileViewController.h
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeiboRequest.h"
#import "WeiboModel.h"
@interface ProfileViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,SinaWeiboRequestDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) WeiboModel *weiboModel;
@end
