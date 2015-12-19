//
//  HomeViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ThemeImgView.h"
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "ThemeButton.h"
#import "WeiboModel.h"
#import "WeiboTableView.h"
#import "WeiboFrameModel.h"
#import "UIScrollView+PullDownRefresh.h"
#import "UIScrollView+PullUpRefresh.h"

#import <AudioToolbox/AudioToolbox.h>
@interface HomeViewController ()
{
    WeiboTableView *_tableView;
    NSMutableArray *_dataArray;
    ThemeImgView *_barImageView;
    ThemeLabel *_barLabel;
    UIButton *button;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    _tableView = [[WeiboTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    self.navigationController.navigationBar.translucent = NO;
//    UIRefreshControl *refresh = [[UIRefreshControl alloc]initWithFrame:CGRectZero];
//    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新"];
//    [refresh addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged ];
    
    __weak HomeViewController *home = self;
    [_tableView addPullDownRefreshBlock:^{
        NSLog(@"shuaxin");
        [home loadNewData];
    }];
    
    [_tableView addInfiniteScrollingWithActionHandler:^{
        
         [home loadOldData];
    }];
    
    [self loadNewData];
    
    
   
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    button = [UIButton buttonWithType:UIButtonTypeCustom ];
    button.frame = CGRectMake(0, 0, kScreenWidth/5, 64);
    
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(loadNewData) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:button];

    NSLog(@"sdfghjk");
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [button removeFromSuperview];
    
}

- (void)loadNewData {
    
    [self showWithTitle:@"加载中！！！！"];
    SinaWeibo *weibo = [self sinaweibo];
    if ([weibo isAuthValid]) {
        NSLog(@"已经登陆");
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        
        if (_dataArray.count != 0) {
            WeiboFrameModel *layouFrame = _dataArray[0];
            WeiboModel *model = layouFrame.weiboModel;
            NSString *idstr = model.weiboIdStr;
            
            [params setObject:idstr forKey:@"since_id"];
            
        }
        
        [params setObject:@"20" forKey:@"count"];
        SinaWeibo *sinaWeibo = [self sinaweibo];
        SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                                                       params:params
                                                   httpMethod:@"GET"
                                                     delegate:self];
        request.tag = 100;
    }else {
        [weibo logIn];
    }
}


- (void)loadOldData {
    
    
    SinaWeibo *weibo = [self sinaweibo];
    if ([weibo isAuthValid]) {
        NSLog(@"已经登陆");
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        
        if (_dataArray.count != 0) {
            
            WeiboFrameModel *layouFrame = _dataArray.lastObject;
            WeiboModel *model = layouFrame.weiboModel;
            NSString *idstr = model.weiboIdStr;
            
            [params setObject:idstr forKey:@"max_id"];
            
        }
        
        [params setObject:@"20" forKey:@"count"];
        SinaWeibo *sinaWeibo = [self sinaweibo];
        SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                                                       params:params
                                                   httpMethod:@"GET"
                                                     delegate:self];
        request.tag = 101;
    }else {
        [weibo logIn];
    }
}



- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaWeibo;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (void)login {
//    
//    SinaWeibo *weibo = [self sinaweibo];
//    
//    NSDictionary *params = @{
//                             @"count":@"20"
//                             
//                             };
//    if ([weibo isAuthValid]) {
//        NSLog(@"已经登录");
//        SinaWeibo *sinaweibo = [self sinaweibo];
//        [sinaweibo requestWithURL:@"statuses/home_timeline.json"
//                           params:[params mutableCopy]
//                       httpMethod:@"GET"
//                         delegate:self];
//    }else {
//        [weibo logIn];
//    }
//    
//}
//NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    //NSLog(@"%@",result);
    [self hide];
    [_tableView.pullToRefreshView stopAnimating];
    [_tableView.infiniteScrollingView stopAnimating];
    
    NSArray *status = result[@"statuses"];
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:status.count];
    for (NSDictionary *dic in status) {
        
        WeiboFrameModel *frameModel = [[WeiboFrameModel alloc]init];
        frameModel.weiboModel = [[WeiboModel alloc]initWithDataDic:dic];
        [modelArray addObject:frameModel];
        
       
    }
    if (modelArray.count == 0) {
        return;
    }
    if (_dataArray == nil) {
        _dataArray = modelArray;
    }
    else {
        if (request.tag == 100) {
            [self showNewWeiboCount:modelArray.count];
            
            NSRange range = NSMakeRange(0, modelArray.count);
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
            
            [_dataArray insertObjects:modelArray atIndexes:indexSet];
        }else {
            if (modelArray.count >1 ) {
                [modelArray removeObjectAtIndex:0];
                [_dataArray addObjectsFromArray:modelArray];
            }else {
                return;
            }
        }
    }
    _tableView.dataArray = _dataArray;
    [_tableView reloadData];
    
    
}


- (void)showNewWeiboCount:(NSInteger)count{
    
    if (_barImageView == nil) {
        _barImageView = [[ThemeImgView alloc]initWithFrame:CGRectMake(10, -40, kScreenWidth-20, 40)];
        _barImageView.imgName = @"timeline_notify.png";
        [self.view addSubview:_barImageView];
        
        _barLabel = [[ThemeLabel alloc]initWithFrame:_barImageView.bounds];
        _barLabel.labelColor = @"timeline_notify.png";
        _barLabel.textAlignment = NSTextAlignmentCenter;
        _barLabel.backgroundColor = [UIColor clearColor];
        [_barImageView addSubview:_barLabel];
    }
    if (count > 0) {
        
        _barLabel.text = [NSString stringWithFormat:@"更新了%li条微博",count];
        [UIView animateWithDuration:0.6 animations:^{
            
            _barImageView.transform = CGAffineTransformMakeTranslation(0, 40);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.6 animations:^{
                [UIView setAnimationDelay:1];
                _barImageView.transform = CGAffineTransformIdentity;
            }];
        }];
    }
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url =[NSURL URLWithString:path];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    
}
@end
