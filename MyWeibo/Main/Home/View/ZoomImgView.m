//
//  ZoomImgView.m
//  MyWeibo
//
//  Created by Allen on 15/12/16.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "ZoomImgView.h"
#import "UIView+UIViewController.h"
@implementation ZoomImgView
{
    UIScrollView *_scrollView;
    UIImageView *_imgView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self tap];
        [self _creatGifView];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self tap];
        [self _creatGifView];
    }
    return self;
}

- (void)tap {
    
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomAction)];
    
    [self addGestureRecognizer:tap];
    
}

- (void)zoomAction {
    
    if ([self.delegate respondsToSelector:@selector(viewWillZoomIn:)]) {
        [self.delegate viewWillZoomIn:self];
    }
    [self creatView];
    CGRect fram = [self convertRect:self.bounds toView:self.window];
    _imgView.frame = fram;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _imgView.frame = _scrollView.frame;
    } completion:^(BOOL finished) {
        [self _loadImage];
    }];
}
- (void)_creatGifView {
    _gifIconView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _gifIconView.hidden = YES;
    _gifIconView.image = [UIImage imageNamed:@"timeline_gif.png"];
    [self addSubview:_gifIconView];
}
- (void)creatView {
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;

        _scrollView.minimumZoomScale = 1.0 ;
        _scrollView.maximumZoomScale = 2.0 ;
        _scrollView.delegate = self;
//        UIGestureRecognizer *tap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(scrollAction)];
//        [_scrollView addGestureRecognizer:tap];
        
        [self.window addSubview:_scrollView];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imgView.image = self.image;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [_scrollView addSubview:_imgView];
        
        //03 添加缩小手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_zoomOut)];
//        [_scrollView addGestureRecognizer:tap];
//

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollAction)];
                [_scrollView addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(savePhoto:)];
        [_scrollView addGestureRecognizer:longPress];

    }
    
}

- (void)savePhoto:(UILongPressGestureRecognizer *)press {
    
    if (press.state ==UIGestureRecognizerStateBegan) {
        NSLog(@"press");
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否保存图片" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        
        [alertView show];
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存图片" preferredStyle:UIAlertControllerStyleAlert
//                                    ];
//    
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            UIImage *image = _imgView.image;
//            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//            
//        }];
//        [alert addAction:action];
//        
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [alert addAction:cancel];
//        
//         UIViewController *vc = self.viewController;
//        [vc presentViewController:alert animated:YES completion:nil];
                                 };
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
     
        UIImage *image = _imgView.image;
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = @"保存成功";
    
    [hud hide:YES afterDelay:1];
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _imgView;
}

- (void)scrollAction {
    
    if ([self.delegate respondsToSelector:@selector(viewWillZoomOut:)]) {
        [self.delegate viewWillZoomOut:self];
    }
    _scrollView.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointZero;
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        _imgView.frame = frame;
        
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        _imgView = nil;
    }];
}

//- (void)_loadFullImage {
//    
//    if (_fullImageUrl != nil) {
//        
//        _hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
//        _hud.mode = MBProgressHUDModeDeterminate;
//        _hud.progress = 0.0;
//        NSURL *url = [NSURL URLWithString:_fullImageUrl];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        _connection = [NSURLConnection connectionWithRequest:request delegate:self];
//
//    }
//    
//}

- (void)_loadImage {
    
    if (_fullImageUrl != nil) {
        _hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
        _hud.mode = MBProgressHUDModeDeterminate;
        _hud.progress = 0.0;
        NSURL *url = [NSURL URLWithString:_fullImageUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
         configuration.allowsCellularAccess = YES;
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionTask *sessionTask = [session dataTaskWithRequest:request];
        
        [sessionTask resume];
    }
}
#pragma mark - sessionTask delegate 
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    
    NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *)response;
    NSDictionary *dic = [httpresponse allHeaderFields];
  
    _dataLength = [dic[@"Content-Length"]doubleValue];
    _data = nil;
    _data = [[NSMutableData alloc]init];
    
      completionHandler(NSURLSessionResponseAllow);
}



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    [_data appendData:data];
    CGFloat progress = _data.length/_dataLength;
    _hud.progress = progress;
    NSLog(@"%lf",progress);
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    
    [_hud hide:YES];
    UIImage *image = [UIImage imageWithData:_data];
    _imgView.image = image;
    CGFloat height = image.size.height/image.size.width *kScreenWidth;
    if (height > kScreenHeight) {
        [UIView animateWithDuration:0.3 animations:^{
            _imgView.height = height;
            _scrollView.contentSize = CGSizeMake(kScreenWidth, height);
        }];
    }
    if (_gifIconView.hidden == NO) {
        [self _showGif];
    }
  
    
    
}

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    
//    NSDictionary *httpHeaderFields = [httpResponse allHeaderFields];
//    
//    NSString *length = [httpHeaderFields objectForKey:@"Content-Length"];
//    _dataLength = [length doubleValue];
//    _data = [[NSMutableData alloc]init];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [_data appendData:data];
//    
//    CGFloat progress = _data.length/_dataLength;
//    NSLog(@"%lf",progress);
//    _hud.progress = progress;
//    
//}
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    
//    [_hud hide:YES];
//    UIImage *image = [UIImage imageWithData:_data];
//    _imgView.image = image;
//    
//    CGFloat scale = image.size.height / image.size.width * kScreenWidth ;
//    if (scale > kScreenHeight) {
//     [UIView animateWithDuration:0.3 animations:^{
//         _imgView.height = scale;
//         _scrollView.contentSize = CGSizeMake(kScreenWidth, scale);
//     }];
//        
//    }
//    if (_gifIconView.hidden == NO ) {
//        [self _showGif];
//    }
//    
//}

- (void)_showGif {
    
    _imgView.image = [UIImage sd_animatedGIFWithData:_data];
}
@end
