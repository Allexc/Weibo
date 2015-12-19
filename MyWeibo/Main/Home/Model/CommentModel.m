//
//  CommentModel.m
//  MyWeibo
//
//  Created by Allen on 15/12/15.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "CommentModel.h"
#import "UserModel.h"
@implementation CommentModel

- (void)setAttributes:(NSDictionary*)dataDic {
    
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = dataDic[@"user"];
    _userModel = [[UserModel alloc]initWithDataDic:userDic];
   
}
@end
