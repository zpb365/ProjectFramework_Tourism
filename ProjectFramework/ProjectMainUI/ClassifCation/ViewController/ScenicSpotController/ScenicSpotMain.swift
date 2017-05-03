//
//  ScenicSpotMain.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/13.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit 

//子控制器的滑动协议
protocol ScrollEnabledDelegate {
    func ScrollEnabledCan()
    func ScrollEnabledNo()
}

class ScenicSpotMain: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var pageMenu: CAPSPageMenu = {
        var controllerArray : [UIViewController] = []
        
        let controller1 = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotHome", Identifier: "ScenicSpotHome") as! ScenicSpotHome
        let controller2 = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotNews", Identifier: "ScenicSpotNews") as!  ScenicSpotNews
        let controller3 = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotPanorma", Identifier: "ScenicSpotPanorma") as!  ScenicSpotPanorma
        let controller4 = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotVideo", Identifier: "ScenicSpotVideo") as!  ScenicSpotVideo
        let controller5 = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotImage", Identifier: "ScenicSpotImage") as!  ScenicSpotImage
        let controller6 = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotAttractions", Identifier: "ScenicSpotAttractions") as!  ScenicSpotAttractions
        let controller7 = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotIntroduce", Identifier: "ScenicSpotIntroduce") as!  ScenicSpotIntroduce
        let controller8 = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotPark", Identifier: "ScenicSpotPark") as!  ScenicSpotPark
        let controller9 = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotTickets", Identifier: "ScenicSpotTickets") as!  ScenicSpotTickets
        controller1.title = "景区首页"
        controller2.title = "资讯"
        controller3.title = "全景"
        controller4.title = "视频"
        controller5.title = "美图"
        controller6.title = "景点"
        controller7.title = "景区介绍"
        controller8.title = "停车场"
        controller9.title = "门票预订"
        //请求回来的数据在这里正向传值
        controller1.ScenicHomeModel = self.ViewModel.ListData.ScenicHome!
        controller2.ScenicNewsModel = self.ViewModel.ListData.ScenicNews!
        controller3.dataArray       = self.ViewModel.ListData.Panorama360!
        controller4.dataArray       = self.ViewModel.ListData.VRVideoClass!
        controller5.dataArray       = self.ViewModel.ListData.BeautifulPicture!
        controller6.dataArray       = self.ViewModel.ListData.ScenicAttractions!
//        controller7.dataArray       = self.ViewModel.ListData.BeautifulPicture!
        controller9.dataArray       = self.ViewModel.ListData.ScenicTicket!
        controller9.ScenicID        = self.ScenicID
        
        controllerArray.append(controller1)
        controllerArray.append(controller2)
        controllerArray.append(controller3)
        controllerArray.append(controller4)
        controllerArray.append(controller5)
        controllerArray.append(controller6)
        controllerArray.append(controller7)
        controllerArray.append(controller8)
        controllerArray.append(controller9)
        
        /********************  为了防止循环引用写的多个代理属性  ********************/
        self.ScrollEnabledDelegate1 = controller1
        self.ScrollEnabledDelegate2 = controller2
        self.ScrollEnabledDelegate3 = controller3
        self.ScrollEnabledDelegate4 = controller4
        self.ScrollEnabledDelegate5 = controller5
        self.ScrollEnabledDelegate6 = controller6
        self.ScrollEnabledDelegate7 = controller7
        self.ScrollEnabledDelegate8 = controller8
        self.ScrollEnabledDelegate9 = controller9
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor().TransferStringToColor("#00ABEE")),
            .bottomMenuHairlineColor(UIColor.clear),
            .menuItemFont(UIFont.systemFont(ofSize: 12)),
            .selectedMenuItemLabelColor(UIColor().TransferStringToColor("#00ABEE")),
            .unselectedMenuItemLabelColor(UIColor.black),
            .menuHeight(30.0),
            .menuItemWidth(50.0),
            .centerMenuItems(true)
        ]

       let pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: self.headView.frame.maxY, width:CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 64), pageMenuOptions: parameters)
        pageMenu.view.tag = 99
        self.addChildViewController(pageMenu)
        self.view.addSubview(pageMenu.view)
        pageMenu.didMove(toParentViewController: self)
        controller1.FuncCallbackValue(value: { [weak self] (tag) in
           self?.pageMenu.moveToPage(tag - 99)
        })
        return pageMenu
    }()
    
    lazy var topButton: UIButton = {
        let topButton =  UIButton(type: .custom)
        topButton.frame = CommonFunction.CGRect_fram(CommonFunction.kScreenWidth - 60, y: CommonFunction.kScreenHeight - 80, w: 30, h: 30)
        topButton.tag = 103
        topButton.isHidden = true
        topButton.clipsToBounds = true
        topButton.layer.cornerRadius = 15
        topButton.backgroundColor = UIColor.white
        topButton.setBackgroundImage(UIImage.init(named: "returntop"), for: .normal)
        topButton.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        return topButton
    }()
    
    
    
    @IBOutlet weak var headView: UIView!//头部视图
    @IBOutlet weak var shufflingBaseView: UIView!//轮播图
    @IBOutlet weak var describeLable: UILabel!//描述
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainImageView: UIImageView!//
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    //拨打电话
    @IBAction func callphone(_ sender: Any) {
        if ViewModel.ListData.Tel != "" {
            CommonFunction.CallPhone(self, number: ViewModel.ListData.Tel)
        }
    }
    
    var CustomNavBar:UINavigationBar!=nil
    var backBtn:UIButton!=nil
    var cellectionBtn:UIButton!=nil
    var shareBtn:UIButton!=nil
    var alph: CGFloat = 0
    var isChange: Bool = true
    var ScenicID = 0
    var ViewModel = ScenicDetailViewModel()
    
    //协议属性
    var ScrollEnabledDelegate1:ScrollEnabledDelegate?
    var ScrollEnabledDelegate2:ScrollEnabledDelegate?
    var ScrollEnabledDelegate3:ScrollEnabledDelegate?
    var ScrollEnabledDelegate4:ScrollEnabledDelegate?
    var ScrollEnabledDelegate5:ScrollEnabledDelegate?
    var ScrollEnabledDelegate6:ScrollEnabledDelegate?
    var ScrollEnabledDelegate7:ScrollEnabledDelegate?
    var ScrollEnabledDelegate8:ScrollEnabledDelegate?
    var ScrollEnabledDelegate9:ScrollEnabledDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        self.initUI()
        self.GetHtpsData()
        
    }
    //MARK: 获取数据
    func GetHtpsData() -> Void {
        ViewModel.GetChannelsScenicDetails(ScenicID: ScenicID) { (result) in
            if result == true{
                
                //print(self.ViewModel.ListData.ScenicNews?.News?[0].ScenicNews?[0].Title)
                self.setData()
            }
        }
    }
    //数据赋值
    func setData() -> Void {
        address.text = self.ViewModel.ListData.Address
        describeLable.text = self.ViewModel.ListData.ScenicName + "---" + self.ViewModel.ListData.ScenicContent
        phoneNumber.text = self.ViewModel.ListData.Tel
        mainImageView.ImageLoad(PostUrl: HttpsUrlImage + self.ViewModel.ListData.Logo)
        self.InitAdv()
    }
    //MARK: 轮播图
    ///初始化轮播广告图
    private func InitAdv(){
        let num = Int((self.ViewModel.ListData.ScenicDetailsAdv?.count)!)
        var Imagelist  = Array<String>()
        for i in 0..<num{
            let model = self.ViewModel.ListData.ScenicDetailsAdv![i]
            Imagelist.append(model.Img)
        }
        let vc = ScrollViewPageViewController(Enabletimer: true,   //是否启动滚动
            timerInterval: 4,     //如果启用滚动，滚动秒数
            ImageList:Imagelist  ,//图片
            frame: shufflingBaseView.bounds,
            Callback_SelectedValue: nil ,
            
            isJumpBtn: nil,
            Callback_JumpValue: nil)
        shufflingBaseView.addSubview(vc.view)
        //刷新
        self.tableView.reloadData()
    }
    //MARK: initUI
    func initUI() -> Void {
        //修饰圆角
        self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width / 2
        self.mainImageView.layer.borderWidth = 5
        self.mainImageView.layer.borderColor = UIColor.white.cgColor
        self.mainImageView.clipsToBounds = true
        
        self.tableView.frame = CGRect.init(x: 0, y: -20, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight + 20)
        self.tableView.tag = 100
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = headView
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 0.0001))
        
        self.view.addSubview(self.topButton)
    }
    //MARK: tableViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = scrollView.contentOffset.y
        if (offset <= 64) {
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00ABEE").withAlphaComponent(0), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray
            cellectionBtn.backgroundColor = UIColor.gray
            shareBtn.backgroundColor = UIColor.gray
        }
        else{
            alph = 1-((200 - offset)/200)
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00ABEE").withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
            cellectionBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
            shareBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
        }
        
        if offset >= headView.frame.height - 64 - 20 {
            if isChange  {
                self.tableView.setContentOffset(CGPoint.init(x: 0, y: headView.frame.height - 64 - 20), animated: true)
                //让主界面不可滑
                self.tableView.isScrollEnabled = false
                self.topButton.isHidden = false
                
                self.setDelegateDone(delegate: ScrollEnabledDelegate1!)
                self.setDelegateDone(delegate: ScrollEnabledDelegate2!)
                self.setDelegateDone(delegate: ScrollEnabledDelegate3!)
                self.setDelegateDone(delegate: ScrollEnabledDelegate4!)
                self.setDelegateDone(delegate: ScrollEnabledDelegate5!)
                self.setDelegateDone(delegate: ScrollEnabledDelegate6!)
                self.setDelegateDone(delegate: ScrollEnabledDelegate7!)
                self.setDelegateDone(delegate: ScrollEnabledDelegate8!)
                self.setDelegateDone(delegate: ScrollEnabledDelegate9!)
                
                isChange = false
            }
            
        }else{
            //让主界面可滑
            self.tableView.isScrollEnabled = true
            self.topButton.isHidden = true
        }
        
    }
    func setDelegateDone(delegate:ScrollEnabledDelegate) -> Void {
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            delegate.ScrollEnabledCan()
            //异步线程加载结束回到主线程渲染UI
            DispatchQueue.main.async(execute: {() -> Void in
            
            })
        })

    }
    func setDelegateDoneCancle(delegate:ScrollEnabledDelegate) -> Void {
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            delegate.ScrollEnabledNo()
            //异步线程加载结束回到主线程渲染UI
            DispatchQueue.main.async(execute: {() -> Void in
                
            })
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //判断是否是请求数据回来了，是就返回自定义控件
        if self.ViewModel.ListData.ScenicName != "" {
            return self.pageMenu.view
        }else{
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CommonFunction.kScreenHeight - 64
    }
    
    //MARK: 设置导航栏
    func setNavBar() -> Void {
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00ABEE").withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
        CustomNavBar.clipsToBounds=true
        self.view.addSubview(CustomNavBar)
        
        let CustomNavItem = UINavigationItem()
        //返回按钮
        backBtn = UIButton(type: .custom)
        backBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        backBtn.tag = 100
        backBtn.backgroundColor = UIColor.gray
        backBtn.layer.cornerRadius = 15
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        //收藏
        cellectionBtn = UIButton(type: .custom)
        cellectionBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        cellectionBtn.adjustsImageWhenHighlighted = false
        cellectionBtn.tag = 101
        cellectionBtn.backgroundColor = UIColor.gray
        cellectionBtn.layer.cornerRadius = 15
        cellectionBtn.setImage(UIImage(named: "collection_normal"), for: .normal)
        cellectionBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        //分享
        shareBtn = UIButton(type: .custom)
        shareBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        shareBtn.tag = 102
        shareBtn.adjustsImageWhenHighlighted = false
        shareBtn.backgroundColor = UIColor.gray
        shareBtn.layer.cornerRadius = 15
        shareBtn.setImage(UIImage(named: "share"), for: .normal)
        shareBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        
        CustomNavItem.leftBarButtonItem=UIBarButtonItem.init(customView: backBtn)
        CustomNavItem.rightBarButtonItems=[UIBarButtonItem.init(customView: shareBtn),UIBarButtonItem.init(customView: cellectionBtn)]
        CustomNavBar.pushItem(CustomNavItem, animated: true)
    }
    //导航栏按钮方法
    func buttonClick(_ button: UIButton){
        switch button.tag {
        case 100:
            _ = self.navigationController?.popViewController(animated: true)
            break
        case 101:
            print("收藏")
            break
        case 102:
            print("分享")
            break
        case 103:
            isChange = true
            self.tableView.setContentOffset(CGPoint.init(x: 0, y:(-20)), animated: true)

            self.setDelegateDoneCancle(delegate: ScrollEnabledDelegate1!)
            self.setDelegateDoneCancle(delegate: ScrollEnabledDelegate2!)
            self.setDelegateDoneCancle(delegate: ScrollEnabledDelegate3!)
            self.setDelegateDoneCancle(delegate: ScrollEnabledDelegate4!)
            self.setDelegateDoneCancle(delegate: ScrollEnabledDelegate5!)
            self.setDelegateDoneCancle(delegate: ScrollEnabledDelegate6!)
            self.setDelegateDoneCancle(delegate: ScrollEnabledDelegate7!)
            self.setDelegateDoneCancle(delegate: ScrollEnabledDelegate8!)
            self.setDelegateDoneCancle(delegate: ScrollEnabledDelegate9!)
            break
        default:
            break
        }
        
    }

}
