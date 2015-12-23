//
//  Common.h
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define kAppKey             @"3716164626"
#define kAppSecret          @"0f350e6ee5f0d559b924701c50e3c60c"
#define kAppRedirectURI     @"http://www.baidu.com"

#import "sinaweibo_ios_sdk/SinaWeibo/SinaWeibo.h"
#import "sinaweibo_ios_sdk/SinaWeibo/SinaWeiboAuthorizeView.h"
#import "sinaweibo_ios_sdk/SinaWeibo/SinaWeiboRequest.h"

#import "UIViewExt.h"
#define  FontSize_Weibo(isDetail) isDetail?17:15
#define  FontSize_Rweibo(isDetail) isDetail?16:14

//微博接口
#define unread_count @"remind/unread_count.json"  //未读消息
#define home_timeline @"statuses/home_timeline.json"  //微博列表
#define comments  @"comments/show.json"   //评论列表
#define send_update @"statuses/update.json"  //发微博(不带图片)
#define send_upload @"statuses/upload.json"  //发微博(带图片)
#define geo_to_address @"location/geo/geo_to_address.json"  //查询坐标对应的位置
#define nearby_pois @"place/nearby/pois.json" // 附近商圈
#define nearby_timeline  @"place/nearby_timeline.json" //附近动态

#define user_show @"users/show.json"//用户信息
#define ios7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define ios8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

#define BASEURL  @"https://api.weibo.com/2/"
#define BaseUrl @"https://api.weibo.com/2/"

#endif /* Common_h */
