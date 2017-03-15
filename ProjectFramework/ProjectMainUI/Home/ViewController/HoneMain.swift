//
//  Home.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/22.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

//自定义Cell的协议 （用于处理滑动业务)
protocol SlidingDelegate {
    func SlidingHidden()      //滑动器 隐藏
    func SlidingShow()      //滑动器 显示
}

class HoneMain: UIViewController,SlidingDelegate,PYSearchViewControllerDelegate {
    
    var pageMenu : CAPSPageMenu?    //滚动菜单
    var CustomNavBar:UINavigationBar?=nil //自定义导航列表
    var statusBarView:UIView?=nil    //状态栏视图
    
    ///圆角（消息NavItem）属性
      lazy var BadgenumberLabel:UILabel = {
        
        let kNameLabelWidth:CGFloat = 8
          let kNameLabelHeight:CGFloat = 8
          let kNameLabelX:CGFloat = 20 // 父视图宽
          let kNameLabelY:CGFloat = 0
        
        let numberlab = UILabel()
        numberlab.frame=CGRect(x: kNameLabelX, y: kNameLabelY, width: kNameLabelWidth, height: kNameLabelHeight)
        numberlab.backgroundColor=UIColor.white
        numberlab.textAlignment = .center
        numberlab.layer.cornerRadius=kNameLabelHeight*0.5
        numberlab.layer.masksToBounds=true
        return numberlab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupNavBar()
       InitPageMenu()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true) 
    }
    
    ///自定义UINavigationBar
    private func SetupNavBar(){
        
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        self.view.addSubview(CustomNavBar!)
        
        let CustomNavItem = UINavigationItem()
        
        CustomNavBar?.pushItem(CustomNavItem, animated: true)
        
        CustomNavBar?.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#FF6347"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
        
        CustomNavItem.leftBarButtonItem=UIBarButtonItem(image: UIImage.init(named: "scanning"), style: .done, target: self, action: #selector(self.leftButtonItem)) //扫描
        
        let rightitem = UIBarButtonItem(customView: UIBarButtonItem().NavItemWithImageName(imageName: "message", highImageName: "message", target: self, action: #selector(self.righButtonItem)))
        rightitem.customView?.addSubview(BadgenumberLabel)
        rightitem.customView?.bringSubview(toFront: BadgenumberLabel)
        
        CustomNavItem.rightBarButtonItem=rightitem  //消息
        
        
        CustomNavItem.titleView=UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "请搜索")
        
    }
    
    //滚动菜单
    func InitPageMenu ( ){
     
        var controllerArray : [UIViewController] = []
        
        let controller1 =   CommonFunction.ViewControllerWithStoryboardName("HomePage", Identifier: "HomePage") as! HomePage
        controller1.HoneMain=self
        controller1.title = "首页"
        let controller2 = CommonFunction.ViewControllerWithStoryboardName("Scenic", Identifier: "Scenic") as!  Scenic
        controller2.title = "景区门票"
        let controller3 = CommonFunction.ViewControllerWithStoryboardName("Hotel", Identifier: "Hotel") as!  Hotel
        controller3.title = "酒店预订"
        let controller4 = CommonFunction.ViewControllerWithStoryboardName("Diet", Identifier: "Diet") as! Diet
        controller4.title = "餐厅餐饮"
        let controller5 = CommonFunction.ViewControllerWithStoryboardName("TravelAgency", Identifier: "TravelAgency") as! TravelAgency
        controller5.title = "旅行社"
        let controller6 = CommonFunction.ViewControllerWithStoryboardName("Meeting", Identifier: "Meeting") as! Meeting
        controller6.title = "会议"
        let controller7 = CommonFunction.ViewControllerWithStoryboardName("Parking", Identifier: "Parking") as!  Parking
        controller7.title = "停车位预订"
        let controller8 = CommonFunction.ViewControllerWithStoryboardName("TourGuide", Identifier: "TourGuide") as! TourGuide
        controller8.title = "导游预订"
        let controller9 = CommonFunction.ViewControllerWithStoryboardName("Shopping", Identifier: "Shopping") as! Shopping
        controller9.title = "购物"
        controllerArray.append(controller1)
        controllerArray.append(controller2)
        controllerArray.append(controller3)
        controllerArray.append(controller4)
        controllerArray.append(controller5)
        controllerArray.append(controller6)
        controllerArray.append(controller7)
        controllerArray.append(controller8)
        controllerArray.append(controller9)
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(CommonFunction.SystemColor()),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor.white),
            .bottomMenuHairlineColor(UIColor.clear),
            .menuItemFont(UIFont.systemFont(ofSize: 12)),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor.white),
            .menuHeight(30.0),
            .menuItemWidth(50.0),
            .centerMenuItems(true)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight), pageMenuOptions: parameters)
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        pageMenu!.didMove(toParentViewController: self)

    }
    
    
    func SearchEvent(){
        let searchViewController =   PYSearchViewController(hotSearches: nil, searchBarPlaceholder: "请输入您要查询的信息")
        searchViewController?.hotSearchStyle = .default
        searchViewController?.searchHistoryStyle = .normalTag
        searchViewController?.delegate=self
        let nav =  CYLBaseNavigationController (rootViewController: searchViewController!)
        self.present(nav, animated: false, completion: nil)
    }
    
    //按下搜索时 或者点搜索列表时
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWithsearchBar searchBar: UISearchBar!, searchText: String!) {
        searchViewController.dismiss(animated: false, completion: nil)
        let vc = CommonFunction.ViewControllerWithStoryboardName("Shopping", Identifier: "Shopping") as! Shopping
        //vc.SearchText=searchText!
        self.navigationController?.show(vc, sender: nil  )
    }
    
    ///消息
    func righButtonItem (){
        let controller9 = CommonFunction.ViewControllerWithStoryboardName("Shopping", Identifier: "Shopping") as! Shopping
        
        self.navigationController?.show(controller9, sender: self)
    }
    
    ///扫描
    func leftButtonItem (){
        ///需要真机调试
        let vc = QQScanViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    ///隐藏导航栏
    internal func SlidingHidden() {
         CustomNavBar?.isHidden=true
        pageMenu?.view.frame=CGRect(x: 0, y: 20, width: (pageMenu?.view.frame.width)!, height: (pageMenu?.view.frame.height)!+40)
        if(statusBarView == nil ) {
        statusBarView=UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(CommonFunction.kScreenWidth), height: CGFloat(20)))
        statusBarView?.backgroundColor = CommonFunction.SystemColor()
            self.view.addSubview(statusBarView!)
        }
    }
    
    ///显示导航栏
    internal func SlidingShow() {
        CustomNavBar?.isHidden=false
        pageMenu?.view.frame=CGRect(x: 0, y: CommonFunction.NavigationControllerHeight, width: (pageMenu?.view.frame.width)!, height: self.view.frame.height-CommonFunction.NavigationControllerHeight)
    }

}
