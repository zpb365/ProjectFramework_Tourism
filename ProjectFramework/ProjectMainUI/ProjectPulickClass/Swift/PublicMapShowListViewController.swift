//
//  ScenicSpotPark.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import RxSwift
import RxCocoa

//地图列表数据模型
class MapListModel: NSObject {
    
    var  lat=""
    var  lng=""
    var title=""
    
}

class PublicMapShowListViewController: UIViewController,BMKMapViewDelegate,BMKLocationServiceDelegate   {
    
    private  var mapView: BMKMapView!
    fileprivate let disposeBag   = DisposeBag() //创建一个处理包（通道）
    var models=[MapListModel]()
    var locService: BMKLocationService!
    
    override func viewWillDisappear(_ animated: Bool) {
        mapView.viewWillDisappear()
        mapView.delegate = nil  // 不用时，置nil
    }
    override func viewDidAppear(_ animated: Bool) {
        self.fd_interactivePopDisabled = true
        //添加所有已知的市场标注
        for index in models{
            
            let lat = CLLocationDegrees(index.lat)
            let Lng = CLLocationDegrees(index.lng)
            //添加大头针
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
    
    //MARK: 大头针标记
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if (annotation.isKind(of: BMKPointAnnotation.self)) {
            let newAnnotationView = BMKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "myAnnotation")
            newAnnotationView?.pinColor = UInt(BMKPinAnnotationColorPurple)
            //newAnnotationView?.paopaoView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 50)
            //print(annotation.coordinate.latitude,annotation.coordinate.longitude,annotation.title!())
            //背景图片
            let width = annotation.title!().getContenSizeWidth(font: UIFont.systemFont(ofSize: 15))
            
            let paopaoView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: width + 90, height: 85))
            paopaoView.image = UIImage.init(named: "paopao.png")
            paopaoView.isUserInteractionEnabled = true
            //文字
            let lable = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: width + 10 , height: 40))
            lable.text = annotation.title!()
            lable.font = UIFont.systemFont(ofSize: 15)
            lable.numberOfLines = 2
            paopaoView.addSubview(lable)
            
            //导航按钮
            let goBtn = UIButton.init(type: .system)
            goBtn.frame = CGRect.init(x: width + 25, y: 15, width: 55, height: 40)
            goBtn.layer.cornerRadius = 4
            goBtn.backgroundColor = UIColor().TransferStringToColor("#00ABEE")
            goBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            goBtn.setTitleColor(UIColor.white, for: .normal)
            goBtn.setTitle("导航", for: .normal)
            goBtn.rx.tap.subscribe(      //返回
                onNext: { value in
                    print("====",annotation.title!())
            }).addDisposableTo(self.disposeBag)
            paopaoView.addSubview(goBtn)
            
            let pView = BMKActionPaopaoView.init(customView: paopaoView)
            newAnnotationView?.paopaoView = pView
            return newAnnotationView
        }else{
            return nil
        }
    }
    //这个是点击的代理
//    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
//        print("点击了大头针",view.annotation.coordinate.longitude,view.annotation.title!())
//        
//    }
    func mapView(_ mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        print("点击了泡泡",view.annotation.coordinate.longitude,view.annotation.title!())
    }
    //MARK: 位置更新代理
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        //print("我位置更新了")
    }
    var isFirst = true
    func didUpdate(_ userLocation: BMKUserLocation!) {
        //print("处理位置坐标更新---",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude)
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
