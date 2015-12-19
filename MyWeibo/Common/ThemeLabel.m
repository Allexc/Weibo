//
//  ThemeLabel.m
//  MyWeibo
//
//  Created by Allen on 15/12/9.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"
@implementation ThemeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:kNotification object:nil];
    }
    return self;
}


- (void)awakeFromNib {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:kNotification object:nil];
}

- (void)themeChange {
    
    self.textColor = [[ThemeManager shareInstance]getThemeColor:_labelColor];
}
- (void)setLabelColor:(NSString *)labelColor {
    
    if (![_labelColor isEqualToString:labelColor]) {
        _labelColor = labelColor;
    }
    self.textColor = [[ThemeManager shareInstance]getThemeColor:labelColor];
}
@end
