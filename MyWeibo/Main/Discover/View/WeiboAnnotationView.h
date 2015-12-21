//
//  WeiboAnnotationView.h
//  MyWeibo
//
//  Created by Allen on 15/12/19.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "WeiboAnnotation.h"
#import "UIImageView+WebCache.h"

@interface WeiboAnnotationView : MKAnnotationView {
    
    UIImageView *_headImageView;
    UILabel *_textLabel;
}

@end
