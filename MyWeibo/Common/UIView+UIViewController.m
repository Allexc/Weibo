//
//  UIView+UIViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/14.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (UIViewController *)viewController {
    
    UIResponder *nextResponder = self.nextResponder;
    
    while (nextResponder !=nil) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        nextResponder = nextResponder.nextResponder;
    }
    
    return  nil;
}
@end
