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
#import "ThemeButton.h"
#import "ZoomImgView.h"
#import "UIProgressView+AFNetworking.h"
@interface SendViewController ()
{
    UITextView *_textView;
    
    ZoomImgView *_zoomImgView;
    UIView *_toolView;
    UIProgressView *_progressView;
    
    FacePanelView *_panelView;
    
}
@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self createtextView];
    [self _creatNavitem];
    [self _creattoolView];
    
}
- (void)selectFaceName:(NSString *)faceName {
    
    NSString *text = _textView.text;
    NSString *alltext = [NSString stringWithFormat:@"%@%@",text,faceName];
    _textView.text = alltext;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [_textView becomeFirstResponder];
}


- (void)_creatNavitem {
    
    ThemeButton *closeButton = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeButton.normalimg = @"button_icon_close.png";
    [closeButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    ThemeButton *sendButton = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendButton.normalimg = @"button_icon_ok.png";
    [sendButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:sendButton];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
}


- (void)rightAction:(UIButton *)button {
    
    NSInteger i = _textView.text.length;
    NSString *error = nil;
    if (i == 0) {
        error = @"微博内容为空";
    }
    else if (i > 140) {
        
        error = @"微博字数超过了140";
    }
    
    if (error != nil) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:error preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSURLSessionDataTask *task = [NetworkService sendWeibo:_textView.text image:_zoomImgView.image block:^(id result, NSURLResponse *response, NSError *error) {
        NSLog(@"发了一条微博");
        [self leftButtonAction];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, kScreenWidth, 20);
        _progressView.progress = 0.0;
        [self.view addSubview:_progressView];
    }
    
    [_progressView setProgressWithUploadProgressOfTask:(NSURLSessionUploadTask *)task animated:YES];

}

- (void)leftButtonAction {
    [_textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    }
- (void)createtextView {
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 200)];
    
    _textView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    //self.navigationController.navigationBar.translucent = NO;
    _textView.layer.cornerRadius = 10;
    _textView.backgroundColor = [UIColor grayColor];
    _textView.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:_textView];
    
    
    _zoomImgView = [[ZoomImgView alloc]initWithFrame:CGRectMake(0, 270, 100, 100)];
    _zoomImgView.delegate = self;
    _zoomImgView.hidden = YES;
    [self.view addSubview:_zoomImgView];
}


- (void)_creattoolView {
    
    _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 300,kScreenWidth, 33)];
    _toolView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_toolView];
    NSArray *imgs = @[
                      @"compose_toolbar_1.png",
                      @"compose_toolbar_4.png",
                      @"compose_toolbar_3.png",
                      @"compose_toolbar_5.png",
                      @"compose_toolbar_6.png"
                      ];

    for (int i=0; i < 5; i++) {
        ThemeButton *button = [[ThemeButton alloc]initWithFrame:CGRectMake((kScreenWidth-200)/6*(i+1)+40*i, 0, 40, 33)];
        
        button.normalimg = imgs[i];
        button.tag = 10+i;
        [button addTarget:self action:@selector(toolButton:) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:button];
    }
    
    _panelView = [[FacePanelView alloc]initWithFrame:CGRectZero];
    [_panelView setFaceDelegate:self];
    _panelView.top = kScreenHeight-64;
    [self.view addSubview:_panelView];
    
}

- (void)toolButton:(UIButton *)button {
    
    if (button.tag == 10) {
        [self _selectPhoto];
    }else if (button.tag == 14) {
        
        if (_textView.isFirstResponder) {
            [_textView resignFirstResponder];
            [self _showPanelView];
        }else{
            [self _hihdPanelView];
            [_textView becomeFirstResponder];
        }
    }
    
}

- (void)_showPanelView {
    
    [UIView animateWithDuration:0.3 animations:^{
        _panelView.bottom = kScreenHeight;
        _toolView.bottom = _panelView.top;
    }];
   
}

- (void)_hihdPanelView {
    [UIView animateWithDuration:0.3 animations:^{
        _panelView.top = kScreenHeight;
    }];
    
}
- (void)_selectPhoto {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionPhoto = [UIAlertAction actionWithTitle:@"相机" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"open camera");
        [self _photoPicker:YES];
    }];
    
    UIAlertAction *actionAcamera = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self _photoPicker:NO];
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
    _zoomImgView.image = image;
    _zoomImgView.hidden = NO;
    
}

- (void)showKeyBoard:(NSNotification *)notification {
    
    NSValue *boundsValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect frame = [boundsValue CGRectValue];
    _toolView.bottom = frame.origin.y;
    
    
}

- (void)viewWillZoomIn:(ZoomImgView *)view {
    NSLog(@"zoom in");
    [_textView resignFirstResponder];
}
- (void)viewWillZoomOut:(ZoomImgView *)view {
     NSLog(@"zoom out");
    [_textView becomeFirstResponder];
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
