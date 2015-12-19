//
//  AppDelegate.h
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SinaWeibo *sinaWeibo;

@end

