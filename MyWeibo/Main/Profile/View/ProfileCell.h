//
//  ProfileCell.h
//  MyWeibo
//
//  Created by Allen on 15/12/22.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WXLabel.h"
@interface ProfileCell : UITableViewCell<WXLabelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *repostLabel;
@property (weak, nonatomic) IBOutlet WXLabel *talkLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *souceLabel;


@property(nonatomic, strong)WeiboModel *weiboModel;
+ (CGFloat)getRowHeight:(WeiboModel *)weiboModel;
@end
