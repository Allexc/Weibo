//
//  BaseNavgationController.m
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "BaseNavgationController.h"
#import "ThemeManager.h"
#import "Common.h"
@interface BaseNavgationController ()

@end

@implementation BaseNavgationController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themechange) name:kNotification object:nil];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themechange) name:kNotification object:nil];
    }
    return self;

    
}


- (void)themechange {
    
    ThemeManager *theme = [ThemeManager shareInstance];
    
    UIImage *image= [theme getThemeImage:@"mask_titlebar64.png"];
    NSLog(@"%@",image);
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName: [theme getThemeColor:@"Mask_Title_color"]
                                               };
    
    self.navigationBar.tintColor = [theme getThemeColor:@"Mask_Title_color"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self themechange];
    
    // Do any additional setup after loading the view.
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
