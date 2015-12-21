//
//  RightViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "RightViewController.h"
#import "Common.h"
#import "ThemeButton.h"
#import "SendViewController.h"
@interface RightViewController ()
{
    SendViewController *_sendVC;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
     _sendVC = [[SendViewController alloc]init];
    for (int i = 1; i < 6; i++) {
        ThemeButton *button = [[ThemeButton alloc]initWithFrame:CGRectMake(15, 64+(i-1)*50, 40, 40)];
        button.normalimg = [NSString stringWithFormat:@"newbar_icon_%i",i];
        
        [self.view addSubview:button];
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
   
}

- (void)buttonAction:(UIButton *)button {
    switch (button.tag) {
        case 101:
            self.modalPresentationStyle = UIModalPresentationPageSheet;
            [self presentViewController:_sendVC animated:YES completion:nil];
            
            break;
        case 102:
            
        
            break;
        case 103:
            
            break;
        case 104:
            
            break;
        case 105:
            
            break;
            
        default:
            break;
    }
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
