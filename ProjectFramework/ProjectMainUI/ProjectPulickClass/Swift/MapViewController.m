//
//  MapViewController.m
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/6/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

#import "MapViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface MapViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView * _mapView;
    BMKLocationService * _locService;
}
@end

@implementation MapViewController

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 22.7869438444;
    coor.longitude = 108.3897399902;
    annotation.coordinate = coor;
    annotation.title = @"测试标签";
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    
    BMKCoordinateRegion region;
    region.center = coor;
    region.span = span;
    
    _mapView.region = region;
    [_mapView addAnnotation:annotation];
}
- (void)dealloc{
    if (_mapView != nil) {
        _mapView = nil;
    }
    NSLog(@"我释放了");
}
#pragma mark - 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是地图";
    self.view.backgroundColor = [UIColor whiteColor];
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.view = _mapView;
    _mapView.buildingsEnabled = YES;
    _mapView.showsUserLocation = YES;//显示定位图层
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy = kCLLocationAccuracyBest;
    _locService.distanceFilter = 0.1f;
    //启动LocationService
    [_locService startUserLocationService];
    
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
    //普通态
    //以下_mapView为BMKMapView对象
    
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"获取坐标成功");
    NSLog(@"定位到的位置为 lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        return newAnnotationView;
    }
    return nil;
}
-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"我点击了");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
