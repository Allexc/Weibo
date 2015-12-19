//
//  WeiboModel.m
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "WeiboModel.h"
#import "UserModel.h"
#import "RegexKitLite.h"
@implementation WeiboModel


- (NSDictionary *)attributeMapDictionary {
    
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                             @"weiboIdStr":@"idstr"
                             };
    
    return mapAtt;
}
- (void)setAttributes:(NSDictionary*)dataDic {
    
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = dataDic[@"user"];
    NSDictionary *statusDic = dataDic[@"retweeted_status"];
    if (self.source != nil) {
        NSString *regex = @">.+<";
        NSArray *array = [self.source componentsMatchedByRegex:regex];
        if (array.count != 0) {
            NSString *source = array[0];
            NSString *subString = [source substringWithRange:NSMakeRange(1,source.length-2)];
            
            self.source = [NSString stringWithFormat:@"来源:%@",subString];
        }
    }

    
     self.userModel = [[UserModel alloc]initWithDataDic:userDic];
    
    if (statusDic != nil) {
        self.weiModel = [[WeiboModel alloc]initWithDataDic:statusDic];
        
        NSString *text = [NSString stringWithFormat:@"@%@:%@",self.weiModel.userModel.screen_name,self.weiModel.text];
        self.weiModel.text = text;

    }
    
    NSString *regex = @"\\[\\w+\\]";
    NSArray *faceItems = [self.text componentsMatchedByRegex:regex];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@".plist"];
    NSArray *faceConfigArray = [NSArray arrayWithContentsOfFile:path];
    
    for (NSString *faceName in faceItems) {
        
        for (NSDictionary *configDic in faceConfigArray) {
            if ([configDic[@"chs"]isEqualToString:faceName]) {
                NSString *imageName = configDic[@"png"];
                NSString *replaceSting = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
                self.text = [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceSting];
            }
            
        }
    }

    
}


@end
