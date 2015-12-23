//
//  MessageViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/7.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "MessageViewController.h"
#import "ImgAttchment.h"
#import "FacePanelView.h"
#import "Common.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FacePanelView *faceView = [[FacePanelView alloc]initWithFrame:CGRectMake(0,100, kScreenWidth, 0)];
    [self.view addSubview:faceView];
    
    
    
}
//
//    //_label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 300, 400)];
//    NSString *str = @"无法接受三季度非生产速度点开始的放假放假什么才是的疯狂倒计时覅是irufsf是开车吗马克思说几个日俄佛挡杀佛深V什么事了目的sfksfsfn snfsfghjjkllllkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkksssssssssssssssssssooooooooooooooooooooooooooooeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";
//    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:str attributes:@{
//                                                                                                    NSForegroundColorAttributeName:[UIColor orangeColor],
//                                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:20 ]
//                                                                                    }];
// 
//    //超链接
////    [string addAttribute:NSLinkAttributeName value:@"http://www.baidu.com" range:[str rangeOfString:@"无法"]];
////
////    _label.attributedText = string;
////    _label.numberOfLines = 0;
////    _label.textAlignment = UIControlContentVerticalAlignmentTop;
////    
////    self.view.userInteractionEnabled = YES;
////    
////    [self.view addSubview:_label];
////
//    ImgAttchment *attachment = [[ImgAttchment alloc]init];
//    attachment.image = [UIImage imageNamed:@"026.gif"];
//    
//    NSAttributedString *imgAttString = [NSAttributedString attributedStringWithAttachment:attachment];
//    
//    [string insertAttributedString:imgAttString atIndex:12];
//    
//    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 70, 200, 200)];
//
//   CGRect rect= [string boundingRectWithSize:CGSizeMake(200, 10000) options: NSStringDrawingUsesLineFragmentOrigin context:nil];
//    
//    CGRect frame = textView.frame;
//    
//    frame.size.height = rect.size.height;
//    
//    textView.frame = frame;
//    
//        textView.backgroundColor = [UIColor grayColor];
//    
//    textView.editable = NO;
//    
//    textView.delegate = self;
//    [self.view addSubview:textView];
//    
//    
//    textView.attributedText = string;
//    // Do any additional setup after loading the view.
//}
//
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
//    NSLog(@"lianjieeeee");
//    return YES;
//}
//
//- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
//    return YES;
//}
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
