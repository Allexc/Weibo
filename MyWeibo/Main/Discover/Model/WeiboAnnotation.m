//
//  WeiboAnnotation.m
//  MyWeibo
//
//  Created by Allen on 15/12/19.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

- (void)setWeiboModel:(WeiboModel *)weiboModel{
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        //通过weiboModel拿到坐标
        
        NSDictionary *geo = weiboModel.geo;
        
        NSArray *coordinates = [geo objectForKey:@"coordinates"];
        
        if (coordinates.count >=2 ) {
            //longitude	string	经度坐标
            //latitude
            NSNumber *longitude = coordinates[1];
            NSNumber *latitude = coordinates[0];
            
            _coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
            
        }
        
        
        
    }
}

@end
