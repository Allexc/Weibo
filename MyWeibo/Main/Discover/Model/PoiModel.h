//
//  PoiModel.h
//  MyWeibo
//
//  Created by Allen on 15/12/18.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface PoiModel : BaseModel
@property (nonatomic ,copy) NSString *poiid;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *lon;
@property (nonatomic ,copy) NSString *lat;
@property (nonatomic ,copy) NSString *phone;
@property (nonatomic ,copy) NSString *icon;
@end
