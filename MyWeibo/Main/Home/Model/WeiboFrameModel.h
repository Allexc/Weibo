//
//  WeiboFrameModel.h
//  MyWeibo
//
//  Created by Allen on 15/12/11.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WXLabel.h"
@interface WeiboFrameModel : UIView
@property (nonatomic,assign) CGRect frame;//weiboView 布局
@property (nonatomic,assign) CGRect textFrame;//微博布局
@property (nonatomic,assign) CGRect rTextFrame;//转发微博布局
@property (nonatomic,assign) CGRect imageFrame;//微博图片布局
@property (nonatomic,assign) CGRect bgImageFrame;//背景图片布局


@property (nonatomic,strong) WeiboModel *weiboModel;
@property (nonatomic, assign) BOOL isDetail;
@end
