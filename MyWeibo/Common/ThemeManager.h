//
//  ThemeManager.h
//  MyWeibo
//
//  Created by Allen on 15/12/9.
//  Copyright © 2015年 Allen. All rights reserved.
//

#define kNotification @"Notification"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemeManager : NSObject

@property(nonatomic, copy)NSString *ThemeName;


+ (instancetype)shareInstance;
- (UIImage *)getThemeImage:(NSString *)imgName;
- (UIColor *)getThemeColor:(NSString *)colorName;
@end
