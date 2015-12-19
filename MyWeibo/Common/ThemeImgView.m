//
//  ThemeImgView.m
//  MyWeibo
//
//  Created by Allen on 15/12/9.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "ThemeImgView.h"
#import "ThemeManager.h"
@implementation ThemeImgView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _topCapHeight = 0.0;
        _leftCapWidth = 0.0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotficationAction) name:kNotification object:nil];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _topCapHeight = 0.0;
    _leftCapWidth = 0.0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotficationAction) name:kNotification object:nil];
    
}


- (void)NotficationAction {
        
    self.image = [[[ThemeManager shareInstance] getThemeImage:_imgName] stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapHeight];
    
//     self.image = [image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapHeight];
}

- (void)setImgName:(NSString *)imgName {
    
    if (![_imgName isEqual:imgName]) {
        _imgName = [imgName copy];
        
        self.image = [[[ThemeManager shareInstance] getThemeImage:_imgName] stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapHeight];
        
    }
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
