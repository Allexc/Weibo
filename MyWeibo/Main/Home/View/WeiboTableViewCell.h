//
//  WeiboTableViewCell.h
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboFrameModel.h"
@interface WeiboTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *comment;

@property (weak, nonatomic) IBOutlet UILabel *transpond;
@property (weak, nonatomic) IBOutlet UILabel *from;
//@property(nonatomic,strong)WeiboModel *model;
@property(nonatomic,strong)WeiboFrameModel *frameModel;
@end
