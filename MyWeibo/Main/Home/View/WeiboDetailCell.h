//
//  WeiboDetailCell.h
//  MyWeibo
//
//  Created by Allen on 15/12/14.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "CommentModel.h"
#import "WXLabel.h"
#import "Common.h"
@interface WeiboDetailCell : UITableViewCell <WXLabelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet WXLabel *commentText;
@property (weak, nonatomic) IBOutlet UILabel *timeText;

@property (nonatomic, strong) CommentModel *commentModel;

+ (float)getCommentHeight: (CommentModel *)comment;
@end
