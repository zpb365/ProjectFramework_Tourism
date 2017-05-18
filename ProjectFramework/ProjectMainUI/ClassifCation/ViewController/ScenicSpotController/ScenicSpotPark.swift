//
//  ScenicSpotPark.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotPark: UIViewController,ScrollEnabledDelegate,BMKMapViewDelegate   {
    
    var mapView: BMKMapView!
    
    var _ScenicParkingList=[ScenicParkingList]()
    
    var  _latitude:CLLocationDegrees=0 //景区
    var  _longitude:CLLocationDegrees=0 //景区
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = BMKMapView(frame: self.view.frame)
        self.view = mapView
        mapView.isBuildingsEnabled=true
        
        if(_latitude==0&&_longitude==0){
            _latitude=Global_latitude
            _longitude=Global_longitude
        }
        //添加所有已知的市场标注
        for index in _ScenicParkingList{
            
            let lat = CLLocationDegrees(index.Lat)
            let Lng = CLLocationDegrees(index.Lng)
            let annotation =  BMKPointAnnotation()  // 添加一个标记点(PointAnnotation）
            //地图中心点坐标
            let center = CLLocationCoordinate2D(latitude: lat!, longitude: Lng!)
            annotation.coordinate = center
            annotation.title = index.parkingName
            
            mapView.addAnnotation(annotation)
        }
        
        //定位到最近的停车场
        if _ScenicParkingList.count > 0 {
            let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(_ScenicParkingList[0].Lat)!, longitude:  CLLocationDegrees(_ScenicParkingList[0].Lng)!)
            let span = BMKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            
            let region = BMKCoordinateRegion(center: center, span: span)
            mapView.region=region
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.viewWillAppear()
        mapView.delegate = self  // 此处记得不用的时候需要置nil，否则影响内存的释放
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mapView.viewWillDisappear()
        mapView.delegate = nil  // 不用时，置nil
    }
    
    //MARK: SlidingDelegate
    func ScrollEnabledCan() {
        //        print("实现代理")
        //        self.WebView. = true
    }
    func ScrollEnabledNo() {
        //        print("实现代理")
        //        self.WebView.isScrollEnabled = false
    }
    deinit {    //销毁页面
        debugPrint("停车场 页面已经销毁")
        if ((mapView) != nil) {
            mapView = nil
        }
    }
    
}
