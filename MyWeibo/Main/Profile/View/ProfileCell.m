//
//  ProfileCell.m
//  MyWeibo
//
//  Created by Allen on 15/12/22.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "ProfileCell.h"
#import "UIImageView+WebCache.h"
#import "WXLabel.h"
#import "Common.h"
@implementation ProfileCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        [self setNeedsLayout];
    }
}
- (void)layoutSubviews {
    
    [_userImg sd_setImageWithURL:[NSURL URLWithString:self.weiboModel.userModel.profile_image_url]];
    _userName.text = self.weiboModel.userModel.screen_name;
    _comment.text =[NSString stringWithFormat:@"评论：%@",self.weiboModel.commentsCount];
    _repostLabel.text = [NSString stringWithFormat:@"转发：%@",self.weiboModel.repostsCount];
    _timeLabel.text = self.weiboModel.createDate;
    _talkLabel.text = self.weiboModel.text;
    _talkLabel.linespace = 5.0f;
    _talkLabel.font = [UIFont systemFontOfSize:15];
    _talkLabel.wxLabelDelegate = self;
    _souceLabel.text = self.weiboModel.source;
}


- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
 {
// 需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?:([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
 }

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
    
    return [UIColor orangeColor];
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel {
    
    return [UIColor purpleColor];
}


+ (CGFloat)getRowHeight:(WeiboModel *)weiboModel {
    
   CGFloat height = [WXLabel getTextHeight:15 width:kScreenWidth text:weiboModel.text linespace:5.0f];
    
    return height;
}
@end
