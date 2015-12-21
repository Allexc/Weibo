//
//  FaceView.m
//  MyWeibo
//
//  Created by Allen on 15/12/21.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "FaceView.h"

#define item_width  (kScreenWidth/7.0)  //单个表情占用的区域宽度
#define item_height 45   //单个表情占用的区域高度

#define face_height 30   //表情图片的宽度
#define face_width 30   //表情图片的高度
@implementation FaceView
{
    NSMutableArray *_pageArray;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (NSInteger)pageNumber {
    
    return _pageArray.count;
}

- (void)_initData {
    
    _pageArray = [[NSMutableArray alloc]init];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    
    NSInteger countOfOnePage = 28;
    NSInteger pageNum;
    
    pageNum = array.count/countOfOnePage;
    if (array.count % countOfOnePage != 0) {
        pageNum +=1;
    }
    
    for (int i=0 ; i< pageNum; i++) {
        
        NSInteger len = array.count - i * countOfOnePage;
        
        if (len < 28) {
            countOfOnePage = len;
        }
        
        NSRange range =NSMakeRange(countOfOnePage * i, countOfOnePage);
        
        NSArray *array2D = [array subarrayWithRange:range];
        [_pageArray addObject:array2D];
        
    }
}

- (void)drawRect:(CGRect)rect {
    
    for (int i = 0;i < _pageArray.count; i++) {
        NSArray *array = _pageArray[i];
        for (int j = 0;j < array.count; j++) {
            <#statements#>
        }
    }
}
@end
