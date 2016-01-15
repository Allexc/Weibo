//
//  HeaderView.m
//  MyWeibo
//
//  Created by Allen on 15/12/22.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "HeaderView.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
#import "BaseNavgationController.h"
#import "UIView+UIViewController.h"
#import "FriendViewController.h"
@implementation HeaderView
{
    UILabel *_atcountLabel;
    UILabel *_fcountLabel;
}
- (void)awakeFromNib {
    
    UIView *attentionView = [[UIView alloc]initWithFrame:_attentionButton.frame];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, (attentionView.height-40)/2, attentionView.width, 40)];
    
    _atcountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, attentionView.width, 20)];
    _atcountLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, attentionView.width, 20)];
    label.text = @"关注";
    label.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:_atcountLabel];
    [view addSubview:label];
    attentionView.layer.cornerRadius = 5;
    [attentionView addSubview:view];
    
    [_attentionButton addTarget:self action:@selector(attentionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    attentionView.backgroundColor = [UIColor orangeColor];
    [self insertSubview:attentionView belowSubview:_attentionButton];
    
   
    UIView *friendView = [[UIView alloc]initWithFrame:_friendButton.frame];
    UIView *fview = [[UIView alloc]initWithFrame:CGRectMake(0, (attentionView.height-40)/2, attentionView.width, 40)];
    
    _fcountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, attentionView.width, 20)];
    _fcountLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *flabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, attentionView.width, 20)];
    flabel.text = @"粉丝";
    flabel.textAlignment = NSTextAlignmentCenter;
    friendView.layer.cornerRadius = 5;
    [fview addSubview:_fcountLabel];
    [fview addSubview:flabel];
    
    [friendView addSubview:fview];
    
    [_friendButton addTarget:self action:@selector(friendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    friendView.backgroundColor = [UIColor orangeColor];
    [self insertSubview:friendView belowSubview:_friendButton];

    
}
- (void)setUserModel:(UserModel *)userModel {
    
    if (_userModel != userModel) {
        _userModel = userModel;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    
    [_userImg sd_setImageWithURL:[NSURL URLWithString:self.userModel.avatar_large]];
    _userName.text = self.userModel.screen_name;
    _userSex.text = self.userModel.gender;
    _province.text = self.userModel.location;
    _introduction.text = self.userModel.descriptionx;
    _total_numberLabel.text = [NSString stringWithFormat:@"共%li条微博",_total_number];
    _atcountLabel.text = [self.userModel.friends_count stringValue];
    _fcountLabel.text = [self.userModel.followers_count stringValue];
}

#pragma mark - buttonAction

- (void)attentionButtonAction {
    
    NSLog(@"attention");
    UIViewController *navc = self.viewController;
    FriendViewController *friendView = [[FriendViewController alloc]init];
    
    [navc.navigationController pushViewController:friendView animated:YES];
    
}

- (void)friendButtonAction {
    
    NSLog(@"friend");
}
@end
