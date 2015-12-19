//
//  PoiCell.h
//  MyWeibo
//
//  Created by Allen on 15/12/18.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoiModel.h"
@interface PoiCell : UITableViewCell

@property (nonatomic, strong) PoiModel *model;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
