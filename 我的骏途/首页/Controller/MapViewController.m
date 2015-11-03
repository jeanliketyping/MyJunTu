//
//  MapViewController.m
//  骏途旅游
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 huiwen. All rights reserved.

#import "MapViewController.h"
#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

static NSTimeInterval const kTimeDelay = 2.5;

@interface MapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{

    MKMapView *_mapView;
    
    CLLocationDegrees _placeLatitude;
    CLLocationDegrees _placeLongitude;
    
}
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) CLLocationManager  *locationManager;//位置管理器
@property (nonatomic,copy)CLGeocoder *geocoder;

@end

@implementation MapViewController

- (CLLocationManager *)locMgr {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        // 定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        // 距离过滤器，当移动距离小于这个值时不会收到回调
        //        _locMgr.distanceFilter = 50;
    }
    return _locationManager;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createViews];
    self.title = @"地图";
    // 添加背景点击事件
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped)];
    recognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//创建mapView
- (void)_createViews{

    _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    //显示用户位置
    _mapView.showsUserLocation = YES;
    //地图显示类型：标准、卫星、混合
    _mapView.mapType = MKMapTypeStandard;
    //设置代理
    _mapView.delegate = self;
    
    //用户跟踪模式
    _mapView.userTrackingMode = MKUserTrackingModeFollow;

    [self.view addSubview:_mapView];
}


//重写set方法
- (void)setPlaceName:(NSString *)placeName{
    
    if (_placeName != placeName) {
        _placeName = placeName;
    }
    
    WS(weakSelf);
    [self.geocoder geocodeAddressString:_placeName completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"找不到你要去的地方！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return ;
        }
        
        CLPlacemark *placemark = [placemarks firstObject];
        _placeLatitude = placemark.location.coordinate.latitude;
        _placeLongitude = placemark.location.coordinate.longitude;
        
        [weakSelf showInMapWithCoordinate:CLLocationCoordinate2DMake(_placeLatitude, _placeLongitude)];
        
        
    }];
    

}



#pragma mark - Private

- (void)showCommonTip:(NSString *)tip {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = tip;
    self.hud.removeFromSuperViewOnHide = YES;
    [self.hud hide:YES afterDelay:kTimeDelay];
}

- (void)showProcessHud:(NSString *)msg {
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view  addSubview:self.hud];
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = msg;
    [self.hud show:NO];
}

/**
 *  点击空白处收起键盘
 */
- (void)backgroundTapped {
    [self keyboardResign];
}

- (void)keyboardResign {
    [self.view endEditing:YES];
}


//将位置信息显示到mapView上
- (void)showInMapWithCoordinate:(CLLocationCoordinate2D)coordinate {
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.025, 0.025));
    [_mapView setRegion:region animated:YES];
    
    [self addAnnotation:coordinate];
}

//添加大头针
- (void)addAnnotation:(CLLocationCoordinate2D)coordinate {
    
    [_mapView removeAnnotations:_mapView.annotations];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = _placeName;
    annotation.coordinate = coordinate;
    [_mapView addAnnotation:annotation];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location = [locations lastObject];
    NSLog(@"我的位置是 - %@", location);
    [self showInMapWithCoordinate:location.coordinate];
    // 根据不同需要停止更新位置
    [manager stopUpdatingLocation];


}











@end
