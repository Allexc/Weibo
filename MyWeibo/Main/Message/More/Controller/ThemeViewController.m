//
//  ThemeViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"

@interface ThemeViewController ()
{
   
    NSArray *_themNamearray;
}
@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
     NSDictionary *themeNameDic= [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ThemeList" ofType:@"plist"]];
    _themNamearray =[themeNameDic allKeys];
                    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _themNamearray.count ;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0;
//}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"themecell" forIndexPath:indexPath];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 20)];
    label.text = _themNamearray[indexPath.row];
    [cell addSubview:label];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [ThemeManager shareInstance].ThemeName = _themNamearray[indexPath.row];
    NSLog(@"%li",indexPath.row);
    NSLog(@"ss=%li",indexPath.section);
    
    
//    NSString *str =_themNamearray[indexPath.row];
//    if (_themeBlock) {
//         _themeBlock(str);
//    }
   

}

- (void)addblock:(themeNameBlock)theBlock {
    if (self.themeBlock != theBlock) {
        self.themeBlock = theBlock;
    }
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
