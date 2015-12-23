//
//  SendViewController.h
//  MyWeibo
//
//  Created by Allen on 15/12/18.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZoomImgView.h"
#import "FaceView.h"
#import "FacePanelView.h"
@interface SendViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZoomImgViewDelegate,FaceViewDelegate>

@end
