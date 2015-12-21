//
//  WeiboAnnotation.h
//  MyWeibo
//
//  Created by Allen on 15/12/19.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "WeiboModel.h"
@interface WeiboAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong)WeiboModel *weiboModel;
// Title and subtitle for use by selection UI.
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate NS_AVAILABLE(10_9, 4_0);

@end
