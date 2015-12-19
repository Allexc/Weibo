//
//  MainTabBarController.m
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "MainTabBarController.h"
#import "Common/Common.h"
#import "ThemeManager.h"
#import "ThemeImgView.h"
#import "ThemeButton.h"
#import "AppDelegate.h"
#import "ThemeLabel.h"
@interface MainTabBarController ()<SinaWeiboRequestDelegate>
{
    
    ThemeImgView *_selectview;
    ThemeImgView *_bgimg;
    NSArray *_titleArray;
    
    ThemeLabel *_countLabel;
    ThemeImgView *_countImg;
    
}

@end

@implementation MainTabBarController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    
//    self.tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Skins/cat/mask_navbar"]];
    //self.tabBar.backgroundColor = [UIColor blueColor];
    //[self.tabBar setBackgroundImage:[UIImage imageNamed:@"Skins/cat/mask_navbar"]];
    [self createTabbar];
    
//    [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
   
}


//将5个storyboard集合到TabBarControll中
- (void)creatView {
    
    _titleArray = @[@"Home",@"Message",@"Profile",@"Discover",@"More"];
    NSMutableArray *mutArray = [NSMutableArray array];
    
    for (NSString *str in _titleArray) {
        
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:str bundle:[NSBundle mainBundle]];
        UINavigationController *navigationController = [storybord instantiateInitialViewController];
        navigationController.title = str;
        [mutArray addObject:navigationController];
        
    }
    
    
    self.viewControllers = mutArray;
    
}

//自定义tabbar
- (void)createTabbar {
    
    _bgimg = [[ThemeImgView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    _bgimg.imgName = @"mask_navbar";
    [self.tabBar addSubview:_bgimg];
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"Skins/cat/mask_navbar"];
    
    NSArray *imgarray = @[@"home_tab_icon_1",@"home_tab_icon_2",@"home_tab_icon_3",@"home_tab_icon_4",@"home_tab_icon_5"];
    for (UIView *view in self.tabBar.subviews) {
        
        Class cls = NSClassFromString(@"UITabBarButton");
        
        if ([view isKindOfClass:cls]) {
            
            [view removeFromSuperview];

        }
      }
    CGFloat Width = kScreenWidth/imgarray.count;
     CGFloat height = CGRectGetHeight(self.tabBar.frame);
    for (int i=0; i<imgarray.count; i++) {
        
        ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*Width, 0, Width, height);
//        [button setImage:[UIImage imageNamed:imgarray[i]] forState:UIControlStateNormal];
        [button setNormalimg:imgarray[i]];
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
        
    }
    
    _selectview = [[ThemeImgView alloc]initWithFrame:CGRectMake(0, 0, Width, 49)];
    _selectview.imgName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectview];
    
    
    
}

- (void)buttonAction:(UIButton *)button {
    
    self.selectedIndex = button.tag-100;
    
    NSLog(@"%li",button.tag);
    [UIView animateWithDuration:0.3 animations:^{
        _selectview.center = button.center;
       
    }];
   
}

- (void)timeAction {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    [sinaWeibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    if (_countImg == nil) {
        _countImg = [[ThemeImgView alloc]initWithFrame:CGRectMake(kScreenWidth/5-32, 0, 32, 32)];
        _countImg.imgName = @"number_notify_9.png";
        [self.tabBar addSubview:_countImg];
        _countLabel = [[ThemeLabel alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
        
        [_countImg addSubview:_countLabel];
        _countLabel.font =[UIFont systemFontOfSize:14];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.labelColor = @"Timeline_Notice_color";
        }
   
    NSInteger count = [result[@"status"]integerValue];
   
    if (count > 0) {
        _countImg.hidden = NO;
        
        if (count > 99) {
            _countLabel.text = @"99+";
        }else {
            _countLabel.text = [result[@"status"]stringValue];
        }
    }else {
        
         _countImg.hidden = YES;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
