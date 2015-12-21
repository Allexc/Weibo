//
//  WeiboAnnotationView.m
//  MyWeibo
//
//  Created by Allen on 15/12/19.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiboAnnotation.h"
@implementation WeiboAnnotationView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, 100, 40);
        
        [self _createSubViews];
        
    }
    return  self;
    
}
- (void)_createSubViews{
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [self addSubview:_headImageView];
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 60, 40)];
    _textLabel.backgroundColor = [UIColor lightGrayColor];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.numberOfLines = 0;
    [self addSubview:_textLabel];
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    WeiboAnnotation *annotation = self.annotation;
    WeiboModel *model = annotation.weiboModel;
    
    NSString *urlStr = model.userModel.profile_image_url;
    
    
    //设置头像和文字
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    _textLabel.text = model.text;
    
    
}



@end
