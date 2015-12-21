//
//  NearbyWeiboViewController.h
//  MyWeibo
//
//  Created by Allen on 15/12/19.
//  Copyright © 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>   
#import <CoreLocation/CoreLocation.h>
@interface NearbyWeiboViewController : UIViewController<MKMapViewDelegate>
{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}
@end
