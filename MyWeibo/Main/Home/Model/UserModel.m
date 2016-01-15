//
//  UserModel.m
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (NSDictionary *)attributeMapDictionary {
    
    NSDictionary *dic = @{
                          @"screen_name":@"screen_name",
                          @"descriptionx":@"description",
                          @"location":@"location",
                          @"avatar_large":@"avatar_large",
                          @"gender":@"gender",
                          @"profile_image_url":@"profile_image_url",
                          @"idstr":@"idstr",
                          @"url":@"url",
                          @"name":@"name",
                          @"followers_count":@"followers_count",
                          @"friends_count":@"friends_count",
                          @"statuses_count":@"statuses_count",
                          @"favourites_count":@"favourites_count"
                          };
    return dic;
}
@end
