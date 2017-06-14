//
//  ScenicSpotPark.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

//地图列表数据模型
class MapListModel: NSObject {
    
    var  lat=""
    var  lng=""
    var title=""
    
}

class PublicMapShowListViewController: UIViewController,BMKMapViewDelegate,BMKLocationServiceDelegate   {
    
    private  var mapView: BMKMapView!
    
    var models=[MapListModel]()
    var locService: BMKLocationService!
    
    override func viewWillDisappear(_ animated: Bool) {
        mapView.viewWillDisappear()
        mapView.delegate = nil  // 不用时，置nil
    }
    override func viewDidAppear(_ animated: Bool) {
        //添加所有已知的市场标注
        for index in models{
            
            let lat = CLLocationDegrees(index.lat)
            let Lng = CLLocationDegrees(index.lng)
            let annotation =  BMKPointAnnotation()  // 添加一个标记点(PointAnnotation）
            //地图中心点坐标
            let center = CLLocationCoordinate2D(latitude: lat!, longitude: Lng!)
            annotation.coordinate = center
            annotation.title = index.title
            mapView.addAnnotation(annotation)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title="地图"
        mapView = BMKMapView(frame: self.view.frame)
        mapView.isBuildingsEnabled=true
        mapView.showsUserLocation = true
        self.view = mapView
        
        
        //初始化BMKLocationService
        locService = BMKLocationService.init()
        locService.delegate = self
        locService.desiredAccuracy = kCLLocationAccuracyBest
        locService.distanceFilter = 0.1
        locService.startUserLocationService()

    }
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if (annotation.isKind(of: BMKPointAnnotation.self)) {
            let newAnnotationView = BMKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "myAnnotation")
            newAnnotationView?.pinColor = UInt(BMKPinAnnotationColorPurple)
            return newAnnotationView
        }else{
            return nil
        }
    }
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        print("我位置更新了")
    }
    var isFirst = true
    func didUpdate(_ userLocation: BMKUserLocation!) {
        print("处理位置坐标更新---",userLocation)
        if isFirst == true {
            
            let center = CLLocationCoordinate2D(latitude: userLocation.location.coordinate.latitude, longitude:  userLocation.location.coordinate.longitude)
            let span = BMKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = BMKCoordinateRegion(center: center, span: span)
            mapView.region=region
            
            isFirst = false
        }
        mapView.updateLocationData(userLocation)
    }
    //处理位置坐标更新
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        mapView.viewWillAppear()
        mapView.delegate = self  // 此处记得不用的时候需要置nil，否则影响内存的释放
        
    }

    deinit {    //销毁页面
        debugPrint("Map页面已经销毁")
        if ((mapView) != nil) {
            mapView = nil
        }
    }
    
}
