//
//  UIImageView+myImg.m
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "UIImageView+myImg.h"

@implementation UIImageView (myImg)


- (void)getImg:(NSString *)urlstring {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        NSURL *url = [NSURL URLWithString:urlstring];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });

    });
   }
@end
