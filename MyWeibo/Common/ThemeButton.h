//
//  ThemeButton.h
//  MyWeibo
//
//  Created by Allen on 15/12/9.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

@property (nonatomic, copy)NSString *normalimg;
@property (nonatomic, copy)NSString *heighimg;
@property (nonatomic, copy)NSString *titleColor;

- (void)setNormalimg:(NSString *)normalimg withHeighimg:(NSString *)heighimg withTitleColor:(NSString *)titleColor;
@end
