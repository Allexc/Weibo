//
//  WeiboView.m
//  MyWeibo
//
//  Created by Allen on 15/12/11.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "WeiboView.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
@implementation WeiboView

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self createView];
    }
    return self;
}



- (void)createView {
    
    _textLabel = [[WXLabel alloc]init];
    _repostLabel = [[WXLabel alloc]init];
    _imageView = [[ZoomImgView alloc]initWithFrame:CGRectZero];
    _imageView.image = [UIImage imageNamed:@"group_btn_pic_on@2x"];
    _bgImgView = [[ThemeImgView alloc]initWithFrame:CGRectZero];
    
    _bgImgView.topCapHeight = 10;
    _bgImgView.leftCapWidth = 20;
    
    _bgImgView.imgName = @"timeline_rt_border_9.png";
    
     [self addSubview:_bgImgView];
     [self addSubview:_textLabel];
      [self addSubview:_repostLabel];
      [self addSubview:_imageView];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    WeiboModel *rweiboModel = _frameModel.weiboModel;
    self.frame = _frameModel.frame;
    _textLabel.frame = _frameModel.textFrame;
    
    _textLabel.font = [UIFont systemFontOfSize:FontSize_Weibo(_frameModel.isDetail)];
    _textLabel.linespace = 5.0f;
    _textLabel.wxLabelDelegate = self;
    
    _repostLabel.frame = _frameModel.rTextFrame;
    _repostLabel.font = [UIFont systemFontOfSize:FontSize_Rweibo(_frameModel.isDetail)];
    _repostLabel.linespace = 5.0f;
    _repostLabel.wxLabelDelegate = self;
    
    _imageView.frame = _frameModel.imageFrame;
    _imageView.gifIconView.hidden = YES;
    if (_imageView.frame.size.height > 0) {
        NSString *extersion;
        _imageView.gifIconView.frame = CGRectMake(_imageView.width-24, _imageView.height-14, 24, 14);
        if (rweiboModel.weiModel == nil) {
            extersion = [rweiboModel.thumbnailImage pathExtension] ;
        }else {
            extersion = [rweiboModel.weiModel.thumbnailImage pathExtension];
        }
        
        if ([extersion isEqualToString:@"gif"]) {
            _imageView.gifIconView.hidden = NO;
        }else {
            _imageView.gifIconView.hidden = YES;
        }
    }
    _bgImgView.frame = _frameModel.bgImageFrame;
    
}
- (void)setFrameModel:(WeiboFrameModel *)frameModel {
    
    if (_frameModel != frameModel) {
        _frameModel = frameModel;
        
        WeiboModel *_weiboModel = _frameModel.weiboModel;
        
      
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_weiboModel.weiModel.thumbnailImage]];
        _imageView.fullImageUrl = _weiboModel.weiModel.originalImage;

        if (_weiboModel.weiModel.thumbnailImage == nil) {
            [_imageView sd_setImageWithURL:[NSURL URLWithString:_weiboModel.thumbnailImage]];
            _imageView.fullImageUrl = _weiboModel.originalImage;
        }
        
        _textLabel.text = _weiboModel.text;
         _repostLabel.text = _weiboModel.weiModel.text;
       
        [self setNeedsLayout];
    }
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

//手指离开当前超链接文本响应的协议方法
- (void)toucheEndWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context {
    NSLog(@"%@",context);
}
//手指接触当前超链接文本响应的协议方法
- (void)toucheBenginWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context {
    
}


//- (void)setWeiboModel:(WeiboModel *)weiboModel {
//    if (_weiboModel != weiboModel) {
//        _weiboModel = weiboModel;
//        
//        
//        
//    }
//}
@end
