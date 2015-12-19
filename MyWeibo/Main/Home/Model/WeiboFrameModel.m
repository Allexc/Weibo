//
//  WeiboFrameModel.m
//  MyWeibo
//
//  Created by Allen on 15/12/11.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "WeiboFrameModel.h"
#import <UIKit/UIKit.h>
#import "Common.h"
#import "WXLabel.h"
#import "UIViewExt.h"

@implementation WeiboFrameModel

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        [self _caculateFrame];
    }
}

- (void)_caculateFrame {
    
    CGFloat weiboWidth;
    if (_isDetail) {
        weiboWidth =  kScreenWidth;
        self.frame = CGRectMake(0, 60, weiboWidth, 0);
    }
    else {
        weiboWidth = kScreenWidth - 20;
         self.frame = CGRectMake(10, 60, weiboWidth, 0);
    }
    
   
    
    CGFloat weiboTextWidth = weiboWidth - 20;
   
    
    NSString *text = _weiboModel.text;
    
//    CGFloat weiboTextHeight = [WXLabel getWXLabelTextHeightWithFontSize:15 width:weiboTextWidth text:text tag:NULL delegate:self];
    
    CGFloat weiboTextHeight = [WXLabel getTextHeight:FontSize_Weibo(_isDetail) width:weiboTextWidth text:text linespace:5.0f];
    
    self.textFrame = CGRectMake(10, 10, weiboTextWidth, weiboTextHeight);
    
    if (_weiboModel.weiModel == nil) {
        
        if (_weiboModel.thumbnailImage != nil) {
            
            CGFloat imgX = CGRectGetMinX(_textFrame);
            CGFloat imgY = CGRectGetMaxY(_textFrame)+10;
            self.imageFrame = CGRectMake(imgX, imgY, 100, 100);
            _frame.size.height = CGRectGetMaxY(_imageFrame);
;
        }
        else{
            
            self.imageFrame = CGRectMake(0, 0, 0, 0);
            _frame.size.height = CGRectGetMaxY(_textFrame);

            
        }
       
        
    }else {
        
        CGFloat weiRWidth = weiboTextWidth-20;
        NSString *rText = self.weiboModel.weiModel.text;
        
//        CGFloat weiRTextHeight = [WXLabel getWXLabelTextHeightWithFontSize:14 width:weiRTextHeight text:rText tag:NULL delegate:self];
        CGFloat weiRTextHeight=[WXLabel getTextHeight:FontSize_Rweibo(_isDetail) width:weiRWidth text:rText linespace:5.0f];
        CGFloat rX = CGRectGetMinX(_textFrame)+10;
        CGFloat rY = CGRectGetMaxY(_textFrame)+10;
        self.rTextFrame = CGRectMake(rX, rY, weiRWidth, weiRTextHeight);
        
        if (_weiboModel.weiModel.thumbnailImage !=nil) {
            CGFloat imgX = CGRectGetMinX(self.rTextFrame);
            CGFloat imgY = CGRectGetMaxY(self.rTextFrame)+5;
            self.imageFrame = CGRectMake(imgX, imgY, 100, 100);
            
            
            _bgImageFrame = CGRectMake(rX-10, rY-10, weiboTextWidth, _rTextFrame.size.height+_imageFrame.size.height+30);
            _frame.size.height = CGRectGetMaxY(_bgImageFrame);

            
        }
        else{
             self.imageFrame = CGRectMake(0, 0, 0, 0);
        _bgImageFrame = CGRectMake(rX-10, rY-10, weiboTextWidth, _rTextFrame.size.height+15);
            _frame.size.height = CGRectGetMaxY(_bgImageFrame);

        }
        
    }
    
    
}
//- (void)_caculateFrame{
//    
//    _frame = CGRectMake(10, 63, kScreenWidth-20, 300);;
//    
//    _textFrame = CGRectMake(10, 0, kScreenWidth-40, 80);
//    _rTextFrame = CGRectMake(10, 80, kScreenWidth-40, 80);
//    _imageFrame = CGRectMake(10, 190, 160, 160);
//    _bgImageFrame = CGRectMake(0, 0, kScreenWidth-20, 300);
//    
//    
//    NSString *text = _weiboModel.text;
//    
//    NSAttributedString *textstring = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
//    
//    CGRect rect=[textstring boundingRectWithSize:CGSizeMake(200, 10000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    CGRect frame = _textFrame;
//    
//    frame.size.height = rect.size.height+10;
//    
//    _textFrame = frame;
//    
//    NSString *rText = _weiboModel.weiModel.text;
//    
//    if (rText != nil) {
//        NSAttributedString *rTextstring = [[NSAttributedString alloc]initWithString:rText attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
//        
//        CGRect rRect=[rTextstring boundingRectWithSize:CGSizeMake(200, 10000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//        
//        CGRect rFrame = _rTextFrame;
//        
//        rFrame.size.height = rRect.size.height+20;
//        _rTextFrame = rFrame;
//
//    }
//
//    
//    
//    _rTextFrame.origin.y = frame.size.height+5;
//    
//    _imageFrame.origin.y = _rTextFrame.origin.y + _rTextFrame.size.height;
//    
//                                                                                                
//    _frame.size.height = frame.size.height+_rTextFrame.size.height+_imageFrame.size.height+15;
//    _bgImageFrame.origin.y = frame.size.height;
//    _bgImageFrame.size.height = _frame.size.height-frame.size.height;
//    
//    
//}


@end
