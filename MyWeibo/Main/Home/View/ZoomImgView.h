//
//  ZoomImgView.h
//  MyWeibo
//
//  Created by Allen on 15/12/16.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Common.h"
#import "UIImage+GIF.h"
@interface ZoomImgView : UIImageView<UIScrollViewDelegate,NSURLSessionDataDelegate>
{
    NSURLConnection *_connection;
    NSMutableData *_data;
    double _dataLength;
    MBProgressHUD *_hud;
}

@property (nonatomic, copy)NSString *fullImageUrl;
@property (nonatomic,strong) UIImageView *gifIconView;

@end
