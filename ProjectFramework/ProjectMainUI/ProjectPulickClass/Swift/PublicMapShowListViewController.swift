//
//  ScenicSpotPark.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import MapKit
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
    let a = 6378245.0
    let ee = 0.00669342162296594323
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
                    CommonFunction.AlertController(self, title: "是否要开启导航？", message: "", ok_name: "确定", cancel_name: "取消", OK_Callback: {
                        
                        let location = self.bd_decrypt(bd_lat: annotation.coordinate.latitude, bd_lon: annotation.coordinate.longitude)//把百度坐标转成火星坐标
                        let tranLocation = self.marsGS2WorldGS(location.coordinate)//把火星坐标转成GPS坐标
                        //print(location.coordinate.latitude,annotation.coordinate.latitude,tranLocation.latitude)
                        let currenItem = MKMapItem.forCurrentLocation()
                        let locItem = MKMapItem.init(placemark: MKPlacemark.init(coordinate: tranLocation, addressDictionary: nil))
                        _ = MKMapItem.openMaps(with: [currenItem,locItem], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsShowsTrafficKey: Int(true)])
                    }, Cancel_Callback: {
                      
                    })
            }).addDisposableTo(self.disposeBag)
            paopaoView.addSubview(goBtn)
            
            let pView = BMKActionPaopaoView.init(customView: paopaoView)
            newAnnotationView?.paopaoView = pView
            return newAnnotationView
        }else{
            return nil
        }
    }
    //MARK: 坐标转换
    //不在中国内
    func outOfChina(_ location: CLLocation) -> Bool {
        if location.coordinate.longitude < 72.004 || location.coordinate.longitude > 137.8347 {
            return true
        }
        if location.coordinate.latitude < 0.8293 || location.coordinate.latitude > 55.8271 {
            return true
        }
        return false
    }
    func transform(toMars location: CLLocation) -> CLLocation {
        //是否在中国大陆之外
        if (self.outOfChina(location)){
            return location
        }
        var dLat: Double = self.transformLatWith(x: location.coordinate.longitude - 105.0, y: location.coordinate.latitude - 35.0)
        var dLon: Double = self.transformLonWith(x: location.coordinate.longitude - 105.0, y: location.coordinate.latitude - 35.0)
        let radLat: Double = location.coordinate.latitude / 180.0 * .pi
        var magic: Double = sin(radLat)
        magic = 1 - ee * magic * magic
        let sqrtMagic: Double = sqrt(magic)
        dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * .pi)
        dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * .pi)
        return CLLocation(latitude: location.coordinate.latitude + dLat, longitude: location.coordinate.longitude + dLon)
    }
    /********************  火星坐标转地图坐标  ********************/
    func marsGS2WorldGS(_ coordinate: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let gLat: Double = coordinate.latitude
        let gLon: Double = coordinate.longitude
        var location = CLLocation(latitude: gLat, longitude: gLon)
        location = self.transform(toMars: location)
        let marsCoor: CLLocationCoordinate2D = location.coordinate
        let dLat: Double = marsCoor.latitude - gLat
        let dLon: Double = marsCoor.longitude - gLon
        return CLLocationCoordinate2DMake(gLat - dLat, gLon - dLon)
    }
    /********************  百度坐标转火星坐标  ********************/
    func bd_decrypt(bd_lat:Double, bd_lon:Double) -> CLLocation {
        
        let x = bd_lon - 0.0065;
        let y = bd_lat - 0.006;
        let z = sqrt(x * x + y * y) - 0.00002 * sin(y * .pi);
        let theta = atan2(y, x) - 0.000003 * cos(x * .pi);
        let gglon = z * cos(theta);
        let gglat = z * sin(theta);
        let location = CLLocation.init(latitude: gglat, longitude: gglon)
        return location
        
    }
    func transformLatWith(x: Double, y: Double) -> Double {
        var ret: Double = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x))
        ret += (20.0 * sin(6.0 * x * .pi) + 20.0 * sin(2.0 * x * .pi)) * 2.0 / 3.0
        ret += (20.0 * sin(y * .pi) + 40.0 * sin(y / 3.0 * .pi)) * 2.0 / 3.0
        ret += (160.0 * sin(y / 12.0 * .pi) + 320 * sin(y * .pi / 30.0)) * 2.0 / 3.0
        return ret
    }
    
    func transformLonWith(x: Double, y: Double) -> Double {
        var ret: Double = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x))
        ret += (20.0 * sin(6.0 * x * .pi) + 20.0 * sin(2.0 * x * .pi)) * 2.0 / 3.0
        ret += (20.0 * sin(x * .pi) + 40.0 * sin(x / 3.0 * .pi)) * 2.0 / 3.0
        ret += (150.0 * sin(x / 12.0 * .pi) + 300.0 * sin(x / 30.0 * .pi)) * 2.0 / 3.0
        return ret
    }

    //这个是点击的代理
//    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
//        print("点击了大头针",view.annotation.coordinate.longitude,view.annotation.title!())
//        
//    }
    func mapView(_ mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        //print("点击了泡泡",view.annotation.coordinate.longitude,view.annotation.title!())
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
