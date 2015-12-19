//
//  CommentModel.h
//  MyWeibo
//
//  Created by Allen on 15/12/15.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "UserModel.h"
@interface CommentModel : BaseModel
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *idstr;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *source;


@property(nonatomic,strong)UserModel *userModel; //评论微博的用户
@end
