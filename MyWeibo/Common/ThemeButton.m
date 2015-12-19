//
//  ThemeButton.m
//  MyWeibo
//
//  Created by Allen on 15/12/9.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"
@implementation ThemeButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themechange) name:kNotification object:nil];
    }
    return self;
}

- (void)awakeFromNib {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themechange) name:kNotification object:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)themechange {
    
    [self loadThemeResource];
    
}
- (void)setNormalimg:(NSString *)normalimg {
    
    if (![_normalimg isEqualToString:normalimg]) {
        _normalimg = [normalimg copy];
         [self setBackgroundImage:[[ThemeManager shareInstance]getThemeImage:_normalimg] forState:UIControlStateNormal];
        
    }
}

- (void)setHeighimg:(NSString *)heighimg {
    
    if (![_heighimg isEqualToString:heighimg]) {
        _heighimg = [heighimg copy];
        [self setBackgroundImage:[[ThemeManager shareInstance]getThemeImage:_heighimg] forState:UIControlStateHighlighted];
    }
}
- (void)setNormalimg:(NSString *)normalimg withHeighimg:(NSString *)heighimg withTitleColor:(NSString *)titleColor {
    
    if (![_normalimg isEqualToString:normalimg]) {
        _normalimg = [normalimg copy];
        [self setBackgroundImage:[[ThemeManager shareInstance]getThemeImage:_normalimg] forState:UIControlStateNormal];
        
    }
    if (![_heighimg isEqualToString:heighimg]) {
        _heighimg = [heighimg copy];
        [self setBackgroundImage:[[ThemeManager shareInstance]getThemeImage:_heighimg] forState:UIControlStateHighlighted];
    }

    if (![_titleColor isEqualToString:titleColor]) {
        _titleColor = [titleColor copy];
        [self setTitleColor:[[ThemeManager shareInstance]getThemeColor:_titleColor] forState:UIControlStateNormal];
    }
    
    

    
}

- (void)loadThemeResource {
    
    [self setBackgroundImage:[[ThemeManager shareInstance]getThemeImage:_normalimg] forState:UIControlStateNormal];
    [self setBackgroundImage:[[ThemeManager shareInstance]getThemeImage:_heighimg] forState:UIControlStateHighlighted];
    [self setTitleColor:[[ThemeManager shareInstance]getThemeColor:_titleColor] forState:UIControlStateNormal];
    
}
@end
