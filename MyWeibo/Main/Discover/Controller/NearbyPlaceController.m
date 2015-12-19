//
//  NearbyPlaceController.m
//  MyWeibo
//
//  Created by Allen on 15/12/18.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import "NearbyPlaceController.h"
#import <CoreLocation/CoreLocation.h>
#import "NetworkService.h"
#import "Common.h"
#import "PoiModel.h"
#import "PoiCell.h"
@interface NearbyPlaceController ()
{
    CLLocationManager *_locationMannager;
    NSMutableArray *_dataArray;
}

@end

@implementation NearbyPlaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近的地点";
    self.view.backgroundColor = [UIColor whiteColor];
    [self _location];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //[_tableView registerClass:[PoiCell class] forCellReuseIdentifier:@"poicell"];
}


#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PoiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"poicell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)_location {
    if (_locationMannager == nil) {
        _locationMannager = [[CLLocationManager alloc]init];
        
    }
    if (ios8) {
        [_locationMannager requestWhenInUseAuthorization];
    }
    
    [_locationMannager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    _locationMannager.delegate = self;
    
    [_locationMannager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [_locationMannager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    
    [self loadNearByPoisWithlon:lon lat:lat];
//    NSLog(@"经度%lf,纬度%lf",coordinate.longitude,coordinate.latitude);
//    
//    NSString *cooridnateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    [params setObject:cooridnateStr forKey:@"coordinate"];
//    
//    [NetworkService requestDataWithURL:geo_to_address HTTPMethod:@"GET" params:params completionHandle:^(id result, NSURLResponse *response, NSError *error) {
//        NSLog(@"%@",result);
//        NSArray *geos = result[@"geos"];
//        if (geos.count > 0) {
//            NSDictionary *dic = [geos lastObject];
//            NSString *addrs = dic[@"address"];
//            NSLog(@"%@",addrs);
//        }
//    }];
}

#pragma mark - 网络获取附近地点
- (void)loadNearByPoisWithlon:(NSString *)lon lat:(NSString *)lat {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:@"50" forKey:@"count"];
    
    [NetworkService requestAFUrl:nearby_pois httpMethod:@"GET" params:params data:nil block:^(id result, NSURLResponse *response, NSError *error) {
        NSArray *pois = [result objectForKey:@"pois"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dic in pois) {
            PoiModel *model = [[PoiModel alloc]initWithDataDic:dic];
            [modelArray addObject:model];
        }
        _dataArray = modelArray;
        [_tableView reloadData];
    }];
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
