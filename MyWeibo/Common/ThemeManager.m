//
//  ThemeManager.m
//  MyWeibo
//
//  Created by Allen on 15/12/9.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager
{
    NSDictionary *_themeDic;
    NSDictionary *_themeColorDic;
}
+ (instancetype)shareInstance {
    static ThemeManager *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
       _ThemeName = @"猫爷";
         NSString *pathstr = [[NSBundle mainBundle]pathForResource:@"ThemeList" ofType:@"plist"];
        _themeDic = [NSDictionary dictionaryWithContentsOfFile:pathstr];
        
        _themeColorDic = [NSDictionary dictionaryWithContentsOfFile:[[self fullpath]stringByAppendingPathComponent:@"config.plist"]];
        

    }
     return self;
}


- (UIImage *)getThemeImage:(NSString *)imgName {
    
   // NSString *path = @"Skins";
    
//    NSString *fullPath = [NSString stringWithFormat:@"%@/%@/%@",path,_ThemeName,imgName];
//    UIImage *image = [UIImage imageNamed:fullPath];
    NSString *fullPath = [self fullpath];
    
    //NSLog(@"pathstr======%@",pathstr);
   //    NSString *filePath = [[_themeDic objectForKey:_ThemeName] stringByAppendingPathComponent:imgName];
//    
    NSString *fullfilePath = [fullPath stringByAppendingPathComponent:imgName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:fullfilePath];
    
    return image;
}

- (UIColor *)getThemeColor:(NSString *)colorName {
    
    NSDictionary *dic = [_themeColorDic objectForKey:colorName];
    
    CGFloat r = [dic[@"R"] floatValue];
    CGFloat g = [dic[@"G"] floatValue];
    CGFloat b = [dic[@"B"] floatValue];
    
    NSNumber *alpha = dic[@"alpha"];
    if (alpha == nil) {
        alpha = @1;
    }
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:[alpha floatValue]];
    
    return color;
    
}

- (void)setThemeName:(NSString *)ThemeName {
    if (![_ThemeName isEqualToString:ThemeName]) {
        _ThemeName = [ThemeName copy];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotification object:nil];
        
    }
}


- (NSString *)fullpath {
    
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *fullpath = [path stringByAppendingPathComponent:[_themeDic objectForKey:_ThemeName]];
    //NSLog(@"%@",fullpath);
    return fullpath;
    
    
}
@end
