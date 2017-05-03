//
//  VisualFeast.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class VisualFeast: UIViewController{
    
    
    
    var pageMenu : CAPSPageMenu?    //滚动菜单

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setNavbar()
        self.initUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#FF4081"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#FF4081"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    //MARK: initUI
    func initUI() -> Void {
        var controllerArray : [UIViewController] = []
        
        let controller1 =   CommonFunction.ViewControllerWithStoryboardName("BeautyImage", Identifier: "BeautyImage") as! BeautyImage
        let controller2 = CommonFunction.ViewControllerWithStoryboardName("PanoramaImage", Identifier: "PanoramaImage") as!  PanoramaImage
        let controller3 = CommonFunction.ViewControllerWithStoryboardName("VRVideo", Identifier: "VRVideo") as!  VRVideo
        controller1.title = "美图"
        controller2.title = "全景"
        controller3.title = "VR视频"
        controllerArray.append(controller1)
        controllerArray.append(controller2)
        controllerArray.append(controller3)
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor().TransferStringToColor("#FF4081")),
            .bottomMenuHairlineColor(UIColor.clear),
            .menuItemFont(UIFont.systemFont(ofSize: 13)),
            .selectedMenuItemLabelColor(UIColor().TransferStringToColor("#FF4081")),
            .unselectedMenuItemLabelColor(UIColor.black),
            .menuHeight(30.0),
            .menuItemWidth(70.0),
            .centerMenuItems(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width:CommonFunction.kScreenWidth, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        pageMenu!.didMove(toParentViewController: self)
    }
    // MARK: 设置导航栏
    func setNavbar(){        
        let CustomNavItem = self.navigationItem
        
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索美图、视频")
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        print("搜索")
    }


}
