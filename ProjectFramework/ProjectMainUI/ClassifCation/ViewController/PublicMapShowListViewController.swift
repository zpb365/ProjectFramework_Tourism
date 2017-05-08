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

class PublicMapShowListViewController: UIViewController,BMKMapViewDelegate   {
    
    private  var mapView: BMKMapView!
    
    var models=[MapListModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //禁用这个流行的姿态一个视图控制器:
        self.fd_interactivePopDisabled = true
        self.title="地图"
        mapView = BMKMapView(frame: self.view.frame)
        self.view = mapView
        mapView.isBuildingsEnabled=true
  
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
        
        //定位到第一个地址
        let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(models[0].lat)!, longitude:  CLLocationDegrees(models[0].lng)!)
        let span = BMKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = BMKCoordinateRegion(center: center, span: span)
        mapView.region=region
        
        
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
    
 
    deinit {    //销毁页面
        debugPrint("Map页面已经销毁")
        if ((mapView) != nil) {
            mapView = nil
        }
    }
    
}
