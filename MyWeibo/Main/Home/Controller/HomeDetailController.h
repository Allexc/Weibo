//
//  HomeDetailController.h
//  MyWeibo
//
//  Created by Allen on 15/12/14.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboFrameModel.h"
#import "SinaWeibo.h"
@interface HomeDetailController : UIViewController <SinaWeiboRequestDelegate>

@property(nonatomic,strong)WeiboFrameModel *weiboFrameModel;
@property(nonatomic,strong)WeiboModel *weiboModel;

@end
