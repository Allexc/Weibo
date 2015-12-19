//
//  ImgAttchment.m
//  MyWeibo
//
//  Created by Allen on 15/12/11.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "ImgAttchment.h"

@implementation ImgAttchment
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
    
    return CGRectMake(0, 0, lineFrag.size.height, lineFrag.size.height);
}
@end
