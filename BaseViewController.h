//
//  BaseViewController.h
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)showLoading:(BOOL)show;
- (void)showWithTitle:(NSString *)title;
- (void)hide;
@end
