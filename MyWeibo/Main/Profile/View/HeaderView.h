//
//  HeaderView.h
//  MyWeibo
//
//  Created by Allen on 15/12/22.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface HeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userSex;
@property (weak, nonatomic) IBOutlet UILabel *province;

@property (weak, nonatomic) IBOutlet UILabel *introduction;
@property (weak, nonatomic) IBOutlet UILabel *total_numberLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *attentionButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *friendButton;

@property(nonatomic,strong) UserModel *userModel;
@property (nonatomic, assign) NSInteger total_number;
@end
