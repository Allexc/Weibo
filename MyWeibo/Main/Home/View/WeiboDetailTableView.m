//
//  WeiboDetailTableView.m
//  MyWeibo
//
//  Created by Allen on 15/12/14.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "WeiboDetailTableView.h"
#import "WeiboDetailCell.h"
#import "WeiboView.h"
#import "Common.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "CommentModel.h"
@implementation WeiboDetailTableView
{
    WeiboView *_weiboView;
    UIView *_view;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _createHeaderView];
        self.dataSource = self ;
        self.delegate = self;
        UINib *nib = [UINib nibWithNibName:@"WeiboDetailCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:@"weibodetailCell"];
        
            
    }
    return self;
}


#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WeiboDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weibodetailCell" forIndexPath:indexPath];
    cell.commentModel = self.commentArray[indexPath.row];
    return cell;
}

- (void)_createHeaderView {
    _view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    _view.backgroundColor =[UIColor clearColor];
    
    _weiboView = [[WeiboView alloc]init];
    
    [_view addSubview:_weiboView];
    
   
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor grayColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    label.text = [NSString stringWithFormat:@"评论：%@",self.commentCount];
    label.font = [UIFont systemFontOfSize:16];
    
    [view addSubview:label];
    
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat height = [self getCellHeight:indexPath.row];
    CGFloat height = [WeiboDetailCell getCommentHeight:_commentArray[indexPath.row]];
    
    return height+10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (void)setWeiboModel:(WeiboModel *)weiboModel {
    if (self.weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        
        _weiboFrameModel = [[WeiboFrameModel alloc]init];
        
        
        self.weiboFrameModel.isDetail = YES;
        
        _weiboFrameModel.weiboModel = _weiboModel;
        
        _weiboView.frameModel = self.weiboFrameModel;
        
        _view.frame = CGRectMake(0, 0, kScreenWidth, _weiboFrameModel.frame.size.height+70);
        
        [self createUserView];
        self.tableHeaderView = _view;


    }
}
- (void)createUserView {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.weiboModel.userModel.profile_image_url]];
    [_view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 200, 20)];
    label.text = self.weiboModel.userModel.screen_name;
    label.font = [UIFont systemFontOfSize:17];
    [_view addSubview:label];
    
    
    UILabel *source = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 200, 20)];
    source.text = self.weiboModel.source;
    source.font = [UIFont systemFontOfSize:12];
    [_view addSubview:source];
    

}

- (CGFloat)getCellHeight:(NSInteger)row {
    
    CommentModel *model = _commentArray[row];
    
    NSString *texe = model.text;
    NSLog(@"%@",texe);
    
    
    NSDictionary *att = @{
                         NSFontAttributeName:[UIFont systemFontOfSize:16 ]
                         };
    CGRect rect = [texe boundingRectWithSize:CGSizeMake(kScreenWidth-50, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil];
    
    return rect.size.height;
    
}
@end
