//
//  ThemeViewController.h
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^themeNameBlock) (NSString *);
@interface ThemeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy)themeNameBlock themeBlock;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)addblock:(themeNameBlock)theBlock;
@end
