//
//  FaceView.m
//  MyWeibo
//
//  Created by Allen on 15/12/21.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "FaceView.h"
#import "Common.h"
#define item_width  (kScreenWidth/7.0)  //单个表情占用的区域宽度
#define item_height 45   //单个表情占用的区域高度

#define face_height 30   //表情图片的宽度
#define face_width 30   //表情图片的高度
@implementation FaceView
{
    NSMutableArray *_pageArray;
    NSString *_selectImgName;
    UIImageView *_magnifierView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
       
        [self _initData];
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
    self.height = item_height*4;
    self.width = kScreenWidth * pageNum;
    
    //03 放大镜表情视图
    //创建放大镜背景视图
    _magnifierView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 92)];
    _magnifierView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier.png"];
    _magnifierView.backgroundColor = [UIColor clearColor];
    _magnifierView.hidden = YES;
    [self addSubview:_magnifierView];
    
    
    //放大镜中的表情
    UIImageView *faceImgView = [[UIImageView alloc] initWithFrame:CGRectMake((_magnifierView.width-face_width)/2, 15, face_width, face_height)];
    faceImgView.backgroundColor = [UIColor clearColor];
    faceImgView.tag = 100;
    [_magnifierView addSubview:faceImgView];
}

- (void)drawRect:(CGRect)rect {
    
    for (int i = 0;i < _pageArray.count; i++) {
        NSArray *array = _pageArray[i];
        for (int j = 0;j < array.count; j++) {
            
            
            NSDictionary *item = array[j];
            NSString *imgName = item[@"png"];
            UIImage *image = [UIImage imageNamed:imgName];
            
            NSInteger row = j/7;
            NSInteger colum = j%7;
            
            CGFloat x = colum*item_width + (item_width - face_width)/2 + kScreenWidth*i;
            
            CGFloat y = row*item_height + (item_height - face_height)/2;
            CGRect frame = CGRectMake(x, y, face_width, face_height);
            
            [image drawInRect:frame];
            
   
            
        }
    }
}

- (void)showThouchImgName:(CGPoint)point {
    //1 计算第几页
    NSInteger pageNum = point.x / kScreenWidth;
    
    //2 计算出是某一页的第几行 第几列
    
    NSInteger row = (point.y - (item_height-face_height)/2)/item_height;
    
    NSInteger column = (point.x - ((item_width-face_width)/2 + pageNum*kScreenWidth))/item_width;
    
    //3 安全纠正
    if (column > 6) {
        column = 6;
    }
    if (column < 0) {
        column = 0;
    }
    if (row < 0) {
        row = 0;
    }
    if (row > 3) {
        row = 3;
    }
    
    NSArray *Array = _pageArray[pageNum];
    
    NSInteger index = row*7+column;
    if (index >= Array.count) {
        return;
    }
    NSDictionary *dic = [Array objectAtIndex:index];
    NSString *imgName = [dic objectForKey:@"png"];
    NSString *faceName = [dic objectForKey:@"chs"];
    
    if (![_selectImgName isEqualToString:faceName]) {
        _selectImgName = faceName;
        CGFloat x = column * item_width +pageNum*kScreenWidth+item_width/2;
        CGFloat y = row * item_height+ item_height/2;
        
        _magnifierView.center = CGPointMake(x, 0);
        _magnifierView.bottom = y;
        
        UIImageView *faceImgView = (UIImageView *)[_magnifierView viewWithTag:100];
        faceImgView.image = [UIImage imageNamed:imgName];

    }
    
}

#pragma mark - UItouch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_magnifierView setHidden:NO];
    
    //SCROLLVIEW禁止滑动
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView =(UIScrollView*)self.superview;
        scrollView.scrollEnabled = NO;
        
    }

    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    [self showThouchImgName:point];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //取得触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self showThouchImgName:point];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_magnifierView setHidden:YES];
    //取消SCROLLVIEW禁止滑动
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView =(UIScrollView*)self.superview;
        scrollView.scrollEnabled = YES;
        
    }
    //取得触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self showThouchImgName:point];
    
    if ([self.delegate respondsToSelector:@selector(selectFaceName:)]) {
        [self.delegate selectFaceName:_selectImgName];
    }

}
@end
