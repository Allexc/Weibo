//
//  SendViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/18.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "SendViewController.h"
#import "ThemeManager.h"
#import "Common.h"
#import "NetworkService.h"
@interface SendViewController ()
{
    UITextView *_textView;
    
    UIImageView *_imageView;
}
@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTopView];
    
    [self createtextView];
    
    
    
    
    
    
}

- (void)createTopView {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    view.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager shareInstance]getThemeImage:@"bg_home.jpg"]];
    [self.view addSubview:view];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(kScreenWidth-90, 20, 40, 50);
    [rightButton setTitle:@"send" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(30, 20, 40, 50);
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];

}

- (void)rightButtonAction:(UIButton *)button {
    
    
    [NetworkService sendWeibo:_textView.text image:nil block:^(id result, NSURLResponse *response, NSError *error) {
        NSLog(@"发了一条微博");
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

}

- (void)leftButtonAction:(UIButton *)button {
    [self resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    }
- (void)createtextView {
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 200)];
    _textView.layer.cornerRadius = 10;
    _textView.backgroundColor = [UIColor grayColor];
    [self becomeFirstResponder];
    [self.view addSubview:_textView];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 270, 100, 100)];
    
    [self.view addSubview:_imageView];
}


- (void)_selectPhoto {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionPhoto = [UIAlertAction actionWithTitle:@"相机" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"open camera");
        [self _photoPicker:NO];
    }];
    
    UIAlertAction *actionAcamera = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self _photoPicker:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:actionAcamera];
    [alertController addAction:actionPhoto];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)_photoPicker:(BOOL)isCamera {
    
    UIImagePickerControllerSourceType sourceType;
    
    if (isCamera) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
        BOOL isCameraAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (! isCameraAvailable) {
            NSLog(@"相机不可以");
            return;
        }
    }else {
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
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
