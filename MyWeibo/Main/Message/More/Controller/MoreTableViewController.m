//
//  MoreTableViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/10.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "MoreTableViewController.h"
#import "ThemeViewController.h"
#import "ThemeManager.h"
@interface MoreTableViewController ()

@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ThemeViewController *theme = [self.storyboard instantiateViewControllerWithIdentifier:@"theme"];
//    
//    [theme addblock:^(NSString *str) {
//        _detailLabelRow1.text = str;
//        NSLog(@"str======%@",str);
//    }];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _detailLabelRow1.text =[ThemeManager shareInstance].ThemeName;
    _imgrow1.image = [[ThemeManager shareInstance]getThemeImage:@"more_icon_theme.png"];
    _imgRwo2.image = [[ThemeManager shareInstance]getThemeImage:@"more_icon_account.png"];
    _imgRow3.image = [[ThemeManager shareInstance]getThemeImage:@"more_icon_feedback.png"];
    _imgRow4.image = [[ThemeManager shareInstance]getThemeImage:@"more_icon_draft.png"];
    
    _labelrow1.textColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_Text_color"];
    _labelRow2.textColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_Text_color"];
    _labelRow3.textColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_Text_color"];
    _labelRow4.textColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_Text_color"];
    
    
    self.tableView.separatorColor = [[ThemeManager shareInstance]getThemeColor:@"More_Item_Line_color"];
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager shareInstance]getThemeImage:@"bg_home.jpg"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setDetailLabelRow1:(UILabel *)detailLabelRow1 {
//    if (self.detailLabelRow1 != detailLabelRow1) {
//        self.detailLabelRow1 = detailLabelRow1;
//        [self.tableView reloadData];
//    }
//}
#pragma mark - Table view data source



//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 1 && indexPath.section == 1) {
//        ThemeViewController *themView = [self.storyboard instantiateViewControllerWithIdentifier:@"theme"];
//        [self.navigationController showViewController:themView sender:nil];
//        NSLog(@"dianji");
//    }
//    NSLog(@"dddddd");
//    
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
