//
//  FacePanelView.h
//  MyWeibo
//
//  Created by Allen on 15/12/21.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"
@interface FacePanelView : UIView<UIScrollViewDelegate>

@property(nonatomic,copy)NSString *FaceName;

- (void)setFaceDelegate:(id<FaceViewDelegate>)delegate;
@end
