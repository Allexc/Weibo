//
//  PoiCell.m
//  MyWeibo
//
//  Created by Allen on 15/12/18.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "PoiCell.h"
#import "UIImageView+WebCache.h"
@implementation PoiCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PoiModel *)model {
    if (_model != model) {
        _model = model;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    
    _title.text = _model.title;
    
    [_image sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    
}
@end
