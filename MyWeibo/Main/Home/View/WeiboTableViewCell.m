//
//  WeiboTableViewCell.m
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "WeiboTableViewCell.h"
#import "WeiboModel.h"
#import "UIImageView+myImg.h"
#import "UIImageView+WebCache.h"
#import "WeiboView.h"
@implementation WeiboTableViewCell
{
    WeiboView *_weiboView;
}
- (void)awakeFromNib {
    _weiboView = [[WeiboView alloc]init];
    _weiboView.backgroundColor = [UIColor clearColor];
    [self addSubview:_weiboView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    WeiboModel *_model = _frameModel.weiboModel;
    _userName.text = _model.userModel.screen_name;
    _userName.font = [UIFont systemFontOfSize:16];
    //[_userImg getImg:_model.userModel.profile_image_url];
    
    [_userImg sd_setImageWithURL:[NSURL URLWithString:_model.userModel.profile_image_url] placeholderImage:[UIImage imageNamed:@"icon"]];
    _comment.text = [NSString stringWithFormat:@"评论：%@",[_model.commentsCount stringValue]];
    _transpond.text = [NSString stringWithFormat:@"转发：%@",[_model.repostsCount stringValue]];;
    _from.text = _model.source;
    _from.font = [UIFont systemFontOfSize:12];
    
}
- (void)setFrameModel:(WeiboFrameModel *)frameModel {
    
    if (_frameModel != frameModel) {
        _frameModel = frameModel;
        
        _frameModel.isDetail = NO;
        _weiboView.frameModel = _frameModel;
        [self setNeedsLayout];
    }
}
//- (void)setModel:(WeiboModel *)model {
//    if (_model != model) {
//        _model = model;
//        
//        _weiboView.weiboModel = _model;
//        [self setNeedsLayout];
//    }
//}
@end
