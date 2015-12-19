//
//  HomeDetailController.m
//  MyWeibo
//
//  Created by Allen on 15/12/14.
//  Copyright © 2015年 Allen. All rights reserved.
//
#define kNotification @"Notification"
#import "HomeDetailController.h"
#import "WeiboDetailTableView.h"
#import "Common.h"
#import "WeiboView.h"
#import "ThemeManager.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "CommentModel.h"
#import "WXRefresh.h"
@implementation HomeDetailController 
{
    WeiboDetailTableView *_weiboDetailTableView;
    NSMutableArray *_dataArray;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager shareInstance]getThemeImage:@"bg_home.jpg"]];
    _weiboDetailTableView = [[WeiboDetailTableView alloc]initWithFrame:self.view.bounds];
    self.tabBarController.tabBar.hidden = YES;
    
    
    _weiboDetailTableView.backgroundColor =[UIColor clearColor];
    
    _weiboDetailTableView.weiboModel= _weiboFrameModel.weiboModel;

    [self.view addSubview:_weiboDetailTableView];
 
    
    __weak HomeDetailController *weakSelf = self;
    [_weiboDetailTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadOldData];
    }];
    
    [self showCommentData];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:kNotification object:nil];
    }
    return self;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:kNotification object:nil];
       
    }
    return self;
}

- (void)themeChange {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager shareInstance]getThemeImage:@"bg_home.jpg"]];
}

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaWeibo;
}


- (void)showCommentData {
    
    SinaWeibo *sinaWeibo = [self sinaweibo];
    
    NSString *strID = _weiboFrameModel.weiboModel.weiboIdStr  ;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setValue:strID forKey:@"id"];
   [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET"
                     delegate:self].tag=100;
    
}

- (void)loadOldData {
    SinaWeibo *sinaWeibo = [self sinaweibo];
    
    
    NSString *maxID = [_weiboFrameModel.weiboModel.weiboId stringValue];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:maxID forKey:@"id"];
   
    
    CommentModel *commentModel = [_dataArray lastObject];
    if (commentModel == nil) {
        return;
    };
    NSString *lastID = commentModel.idstr;
    [params setValue:lastID forKey:@"max_id"];
    SinaWeiboRequest *request =[sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    request.tag = 101;
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    //NSLog(@"%@",result);
    [_weiboDetailTableView.infiniteScrollingView stopAnimating];
   
    NSArray *dataArray = result[@"comments"];
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dic in dataArray) {
        CommentModel *comment = [[CommentModel alloc]initWithDataDic:dic];
        [modelArray addObject:comment];
       
    }
    
    if (request.tag == 101) {
        NSLog(@"追加评论");
        if (modelArray.count > 1) {
             NSLog(@"追加新的评论");
            [modelArray removeObjectAtIndex:0];
            [_dataArray addObjectsFromArray:modelArray];

        }else {
            return;
                    }
    }else if(request.tag== 100) {
        _dataArray = modelArray;
    }
    _weiboDetailTableView.commentArray = _dataArray;
    
    NSNumber *total_number = result[@"total_number"];
    _weiboDetailTableView.commentCount = [total_number stringValue];
    
    [_weiboDetailTableView reloadData];

}
//- (instancetype)init {
//    if (self = [super init]) {
//       
//        _weiboDetailTableView = [[WeiboDetailTableView alloc]initWithFrame:self.view.bounds];
//        _weiboView = [[WeiboView alloc]init];
//        
//        [_weiboDetailTableView addSubview: _weiboView];
//        [self.view addSubview:_weiboDetailTableView];
//        
//
//    }
//    return self;
//}
//- (void)viewWillAppear:(BOOL)animated
// {
//    [super viewWillAppear:animated];
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
//    view.backgroundColor = [UIColor orangeColor];
//    [_weiboDetailTableView addSubview: view];
//     _weiboView = [[WeiboView alloc]init];
//     
//     [_weiboDetailTableView addSubview: _weiboView];
//}
//- (void)setWeiboFrameModel:(WeiboFrameModel *)weiboFrameModel {
//    if (self.weiboFrameModel != weiboFrameModel) {
//        self.weiboFrameModel = weiboFrameModel;
//        
//        _weiboView.frameModel = weiboFrameModel;
//    }
//}
@end
