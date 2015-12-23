//
//  FacePanelView.m
//  MyWeibo
//
//  Created by Allen on 15/12/21.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "FacePanelView.h"
#import "FaceView.h"
#import "Common.h"
@implementation FacePanelView
{
    UIPageControl *_pageContrl;
    UIScrollView *_scrollView;
    FaceView *_faceView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self creatView];
    }
    return self;
}

- (void)setFaceDelegate:(id<FaceViewDelegate>)delegate {
    _faceView.delegate = delegate;
}

- (void)creatView {
    
    _faceView = [[FaceView alloc]initWithFrame:CGRectZero];
    _faceView.backgroundColor = [UIColor clearColor];
    
    [_scrollView addSubview:_faceView];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _faceView.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.clipsToBounds = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(_faceView.width, _faceView.height);
    
    _scrollView.delegate = self;
    
    [_scrollView addSubview:_faceView];
    [self addSubview:_scrollView];
    
    
    _pageContrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollView.bottom, kScreenWidth, 20)];
    _pageContrl.numberOfPages = _faceView.pageNumber;
    
    _pageContrl.autoresizingMask = UIViewAutoresizingNone;
    [self addSubview:_pageContrl];
    
    self.width = kScreenWidth;
    self.height = _pageContrl.height + _scrollView.height;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _pageContrl.currentPage = scrollView.contentOffset.x/kScreenWidth;
}
@end
