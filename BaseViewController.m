//
//  BaseViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeManager.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "UIViewController+MMDrawerController.h"
#import "Common.h"
#import "MBProgressHUD.h"
@interface BaseViewController ()
{
    UIView *_tipView;
    MBProgressHUD *HUD;
}
@end

@implementation BaseViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

- (void)leftAction {
    NSLog(@"left");
    MMDrawerController *mmDrawer = self.mm_drawerController;
    [mmDrawer openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    
}
- (void)rightAction {
    NSLog(@"right");
    MMDrawerController *mmDrawer = self.mm_drawerController;
    [mmDrawer openDrawerSide:MMDrawerSideRight animated:YES completion:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor orangeColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager shareInstance]getThemeImage:@"bg_home.jpg"]];
    
    if (self.navigationController.viewControllers.count == 1) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    }
    
    // Do any additional setup after loading the view.
}

#pragma  mark - 加载提示

- (void)showLoading:(BOOL)show {
    
    if (_tipView == nil) {
        _tipView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight/2 - 15, kScreenWidth, 30)];
        _tipView.backgroundColor = [UIColor clearColor];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        [_tipView addSubview:activityView];
        
        //2 label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"玩命加载中...";
        label.textColor = [UIColor blackColor];
        
        [label sizeToFit];//子适应大小
        [_tipView addSubview:label];
        
        //设置位置
        label.left = (kScreenWidth-label.width)/2;
        activityView.right = label.left-5;

    }
    if (show) {
        [self.view addSubview:_tipView];
    }else {
        if (_tipView.superview) {
            [_tipView removeFromSuperview];
        }
    }
}



- (void)showWithTitle:(NSString *)title {
//    HUD = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
    
    if (HUD == nil) {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    HUD.labelText = title;
    [HUD show:YES];
    HUD.dimBackground = YES;
    
}

- (void)hide {
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    //自定义视图
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.labelText = @"加载完成";
    //延迟隐藏
    [HUD hide:YES afterDelay:1];
    HUD = nil;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
