//
//  WeiboView.h
//  MyWeibo
//
//  Created by Allen on 15/12/11.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboFrameModel.h"
#import "ThemeImgView.h"
#import "WXLabel.h"
#import "ZoomImgView.h"
@interface WeiboView : UIView<WXLabelDelegate>

@property (nonatomic, strong)WXLabel *textLabel;
@property (nonatomic, strong)WXLabel *repostLabel;
@property (nonatomic, strong)ZoomImgView *imageView;
@property (nonatomic, strong)ThemeImgView *bgImgView;

//@property (nonatomic, strong)WeiboModel *weiboModel;
@property (nonatomic, strong)WeiboFrameModel *frameModel;
@end
