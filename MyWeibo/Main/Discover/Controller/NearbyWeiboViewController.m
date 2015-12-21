//
//  NearbyWeiboViewController.m
//  MyWeibo
//
//  Created by Allen on 15/12/19.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "NearbyWeiboViewController.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
#import "NetworkService.h"
#import "Common.h"
#import "WeiboModel.h"
#import "HomeDetailController.h"
@interface NearbyWeiboViewController ()

@end

@implementation NearbyWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _creatMaoView];
}

- (void)_creatMaoView {
    
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
   // _mapView.userTrackingMode = MKUserTrackingModeFollow;
    //创建两个标注model对象，然后添加到mapView中
//    WeiboAnnotation *annotation1 = [[WeiboAnnotation alloc] init];
//    
//    CLLocationCoordinate2D coordinate1 = {30.2242,120.2019};
//    [annotation1 setCoordinate:coordinate1];
//    
//    [_mapView addAnnotation:annotation1];
//    
//    
//    WeiboAnnotation *annotation2 = [[WeiboAnnotation alloc] init];
//    CLLocationCoordinate2D coordinate2 = {30.2142,120.2019};
//    [annotation2 setCoordinate:coordinate2];
//    
//    [_mapView addAnnotation:annotation2];
    [self.view addSubview:_mapView];
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    
    for (int i; i < views.count; i++) {
        WeiboAnnotationView *annotationView = (WeiboAnnotationView *)views[i];
        if (![annotationView isKindOfClass:[WeiboAnnotationView class]]) {
            continue;
        }
        annotationView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        annotationView.alpha = 0.5;
        
        [UIView animateWithDuration:1 animations:^{
            [UIView setAnimationDelay:i*0.1];
            annotationView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            annotationView.alpha = 1.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    annotationView.transform = CGAffineTransformMakeScale(1, 1);
                }];
            }

        }];
        
    }
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(10_9, 4_0) {
    
    HomeDetailController *detailVc = [[HomeDetailController alloc]init];
    
    WeiboAnnotation *annotabtion = view.annotation;
    WeiboModel *weiboModel = annotabtion.weiboModel;
    
    WeiboFrameModel *frameModel = [[WeiboFrameModel alloc]init];
    frameModel.weiboModel = weiboModel;
    
    detailVc.weiboFrameModel = frameModel;
    
    [self.navigationController pushViewController:detailVc animated:YES];
    
}
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    NSLog(@"start");
}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView {
    NSLog(@"stop");
}



- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"update");
    CLLocation *location = userLocation.location;
    CLLocationCoordinate2D coordinate = location.coordinate;
     NSLog(@"longitude = %lf,latitude = %lf",coordinate.longitude,coordinate.latitude);
    
    NSString *longitudeStr = [NSString stringWithFormat:@"%lf",coordinate.longitude];
    
    NSString *latitudeStr = [NSString stringWithFormat:@"%lf",coordinate.latitude];
    [self _loadNearbyWeiboWithLong:longitudeStr lat:latitudeStr];
    
    MKCoordinateSpan  span = {0.5,0.5};
    CLLocationCoordinate2D center = coordinate;
    MKCoordinateRegion region = {center,span};//中心坐标，参数
    //设置地图显示区域
    [mapView setRegion:region];

}

- (void)_loadNearbyWeiboWithLong:(NSString *)longstr lat:(NSString *)latstr {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:longstr forKey:@"long"];
    [params setObject:latstr forKey:@"lat"];
    [params setObject:@50 forKey:@"count"];
    [NetworkService requestDataWithURL:nearby_timeline HTTPMethod:@"GET" params:params completionHandle:^(id result, NSURLResponse *response, NSError *error) {
        NSArray *status = [result objectForKey:@"statuses"];
        NSMutableArray *annotationArray = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dic in status) {
            WeiboModel *weiboModel = [[WeiboModel alloc]initWithDataDic:dic];
            if (![weiboModel.geo isEqual:[NSNull null]]) {
                WeiboAnnotation *annotation = [[WeiboAnnotation alloc]init];
                
                annotation.weiboModel = weiboModel;
                [annotationArray addObject:annotation];
            }
        }
        
        NSLog(@"%li条微博",annotationArray.count);
        [_mapView addAnnotations:annotationArray];
    }];
    
}
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[WeiboAnnotation class]]) {
        WeiboAnnotationView *annotationView = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (annotationView == nil) {
            annotationView = [[WeiboAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"view"];
        }
        
        annotationView.annotation = annotation;
        return annotationView;
    }
   
    return nil;
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
