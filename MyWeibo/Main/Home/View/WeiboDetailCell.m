//
//  WeiboDetailCell.m
//  MyWeibo
//
//  Created by Allen on 15/12/14.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "WeiboDetailCell.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "WXLabel.h"
#import "UIViewExt.h"
@implementation WeiboDetailCell


- (void)layoutSubviews {
    
    self.commentText.text = self.commentModel.text;
    self.commentText.wxLabelDelegate = self;
    self.commentText.font= [UIFont systemFontOfSize:16];
    self.commentText.linespace = 5.0;
    
    self.userName.text = self.commentModel.userModel.screen_name;
    self.timeText.text = self.commentModel.created_at;
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:self.commentModel.userModel.profile_image_url]];
}

//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
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


+ (float)getCommentHeight: (CommentModel *)comment {
    
    CGFloat height = [WXLabel getTextHeight:16.0f width:kScreenWidth-70 text:comment.text linespace:5];
    return height+40;
}

@end
