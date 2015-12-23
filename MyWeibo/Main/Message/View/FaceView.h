//
//  FaceView.h
//  MyWeibo
//
//  Created by Allen on 15/12/21.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FaceViewDelegate <NSObject>

- (void)selectFaceName:(NSString *)faceName;

@end
@interface FaceView : UIView
@property (nonatomic, readonly)NSInteger pageNumber;
@property (nonatomic, weak)id<FaceViewDelegate> delegate;

@end
