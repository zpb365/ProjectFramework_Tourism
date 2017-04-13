//
//  Home.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/22.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class HoneMain: CustomTemplateViewController,PYSearchViewControllerDelegate {
    
    
    @IBOutlet weak var Adv_View: UIView!    //广告轮播
    
    @IBOutlet weak var tableView: UITableView!  //tableview
    
    var CustomNavBar:UINavigationBar?=nil //自定义导航列表
    
    fileprivate let disposeBag   = DisposeBag() //创建一个处理包（通道）
    
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
    
    var currentHeadlinesBtn = UIButton() //智慧头条
    lazy var SectionHeadlinesButtonBar: UIView = {
        let topButtonBar = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 25, w: CommonFunction.kScreenWidth, h: 40))
        topButtonBar.backgroundColor = UIColor.white
        let titleArray: Array=["政策法规","行业信息","景区公告","通知公告"]
        for i in 0..<titleArray.count {
            let title = titleArray[i]
            let button = UIButton.init(type: .system)
            let frame_x = CGFloat((CommonFunction.kScreenWidth/CGFloat(titleArray.count))*CGFloat(i))
            button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:CommonFunction.kScreenWidth / CGFloat(titleArray.count) , h: 35)
            button.tag = 1 + i
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.rx.tap.subscribe(
                onNext:{ [weak self] value in
                    UIView.animate(withDuration: 0.3) { //点击滑动绑定事件
                        let line = self?.SectionHeadlinesButtonBar.viewWithTag(666)
                        line?.center.x = button.center.x
                        button.setTitleColor(CommonFunction.SystemColor(), for: .normal)
                        self?.currentHeadlinesBtn.setTitleColor(UIColor.gray, for: .normal)
                        self?.currentHeadlinesBtn = button
                    }
                    
            }).addDisposableTo(self.disposeBag)
            
            if (i == 0) {
                button.setTitleColor(CommonFunction.SystemColor(), for: .normal)
                self.currentHeadlinesBtn = button
                let bottomLine = UIView()
                bottomLine.tag = 666
                bottomLine.frame = CommonFunction.CGRect_fram(0, y: 30, w: 60, h: 2)
                bottomLine.center.x = button.center.x
                bottomLine.backgroundColor = CommonFunction.SystemColor()
                topButtonBar.addSubview(bottomLine)
            }
            topButtonBar.addSubview(button)
        }
        return topButtonBar
    }()
    
    
    var currentVisualBtn = UIButton() //视觉盛宴
    lazy var SectionVisualButtonBar: UIView = {
        let topButtonBar = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 25, w: CommonFunction.kScreenWidth, h: 40))
        topButtonBar.backgroundColor = UIColor.white
        let titleArray: Array=["美图","全景","VR视频"]
        for i in 0..<titleArray.count {
            let title = titleArray[i]
            let button = UIButton.init(type: .system)
            let frame_x = CGFloat((CommonFunction.kScreenWidth/CGFloat(titleArray.count))*CGFloat(i))
            button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:CommonFunction.kScreenWidth / CGFloat(titleArray.count) , h: 35)
            button.tag = 1 + i
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.rx.tap.subscribe(
                onNext:{ [weak self] value in
                    UIView.animate(withDuration: 0.3) { //点击滑动绑定事件
                        let line = self?.SectionVisualButtonBar.viewWithTag(666)
                        line?.center.x = button.center.x
                        button.setTitleColor(CommonFunction.SystemColor(), for: .normal)
                        self?.currentVisualBtn.setTitleColor(UIColor.gray, for: .normal)
                        self?.currentVisualBtn = button
                    }
                    
            }).addDisposableTo(self.disposeBag)
            
            if (i == 0) {
                button.setTitleColor(CommonFunction.SystemColor(), for: .normal)
                self.currentVisualBtn = button
                let bottomLine = UIView()
                bottomLine.tag = 666
                bottomLine.frame = CommonFunction.CGRect_fram(0, y: 30, w: 60, h: 2)
                bottomLine.center.x = button.center.x
                bottomLine.backgroundColor = CommonFunction.SystemColor()
                topButtonBar.addSubview(bottomLine)
            }
            topButtonBar.addSubview(button)
        }
        return topButtonBar
    }()
    
    ///添加当前tableview的SectionView
    func TableViewHead(view:UIView,text:String,section:Int){
        if(view.subviews.count==0){ //判断避免一直添加
            let uiview = UIView(frame: CGRect(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 30))
            uiview.backgroundColor=UIColor.white
            let lineColor = UILabel(frame: CGRect(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 6))
            lineColor.backgroundColor=CommonFunction.LineColor()
            let labColor = UILabel(frame: CGRect(x: 10, y: 12, width: 4, height: 12))
            labColor.backgroundColor=CommonFunction.SystemColor()
            let labText = UILabel(frame: CGRect(x: labColor.frame.maxX+5, y: 8, width: 100, height: 20))
            labText.font=UIFont.boldSystemFont(ofSize: 12)
            labText.textColor=UIColor.gray
            labText.text=text
            uiview.addSubview(lineColor)
            uiview.addSubview(labColor)
            uiview.addSubview(labText)
            if(section==0){ //头条
                lineColor.isHidden=true
                view.addSubview(SectionHeadlinesButtonBar)
            }
            if(section==2){ //视觉盛宴
                view.addSubview(SectionVisualButtonBar)
            }
             view.addSubview(uiview)
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame=CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-(CommonFunction.NavigationControllerHeight+49))
        self.InitCongif(tableView)
        SetupNavBar()
        InitAdv()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true) 
    }
    
   override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 1    //热门推荐
        default:
            break
        }
         return 2
    }
    
    let _heightForHeaderInSection=[60,40,60,40,40,40,40,40,40,40]   //行头部高度
    let _heightForHeaderInSectionText=["智慧头条","热门推荐","视觉盛宴","景区","酒店","餐厅","旅行社","会展","特产","游记攻略"]   //行头部文本
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat(_heightForHeaderInSection[section])
    }
    
    let _heightForRowAt=[55,105,100,100,155,115,155,115,160,80]  //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return CGFloat(_heightForRowAt[indexPath.section])
    }
    
   
    let _viewForHeaderInSection=[UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView()] //SectionHeadView
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { 
        _viewForHeaderInSection[section].frame=CGRect(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CGFloat(_heightForHeaderInSection[section]))  //设置UIView的高宽 
        TableViewHead(view: _viewForHeaderInSection[section], text:_heightForHeaderInSectionText[section],section: section)
        return _viewForHeaderInSection[section]
    }
    
    let identifier = ["headlines","recommended","visual","scenic","hotel","restaurant","travelAcy","meeting","specialty","travelGuide"]
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! HeadlinesViewCell
            return  cell    //头条
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! RecommendedViewCell
            cell.InitConfig("")
            return  cell    //推荐
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! VisualViewCell
            return  cell    //视觉盛宴
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! ScenicViewCell
            return  cell    //景区
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! HotelViewCell
            return  cell    //酒店
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! RestaurantViewCell
            return  cell    //餐厅
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! TravelAcyViewCell
            return  cell    //旅行社
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! MeetingViewCell
            return  cell    //会展
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! SpecialtyViewCell
            return  cell    //特产
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! TravelGuideViewCell
            return  cell    //游记
        default:
            break
        }
        return UITableViewCell()
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
    
    ///初始化轮播广告图
    private func InitAdv(){
        
        let Imagelist  = ["index1","index2","index3","index4"]
        let vc = ScrollViewPageViewController(Enabletimer: true,   //是否启动滚动
            timerInterval: 4,     //如果启用滚动，滚动秒数
            ImageList:Imagelist  ,//图片
            frame: Adv_View.frame,
            Callback_SelectedValue: nil ,
            isJumpBtn: nil,
            Callback_JumpValue: nil)
        
        Adv_View.addSubview(vc.view)
        
    }

    ///搜索事件
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
        let vc = CommonFunction.ViewControllerWithStoryboardName("SearchProduct", Identifier: "SearchProduct") as! SearchProductViewController
        vc.SearchText=searchText!
        self.navigationController?.show(vc, sender: nil  )
    }
    
    ///消息
    func righButtonItem (){
        let vc = CommonFunction.ViewControllerWithStoryboardName("Message", Identifier: "Message") as! MessageViewController
        self.navigationController?.show(vc, sender: self)
    }
    
    ///扫描
    func leftButtonItem (){
        
        ///需要真机调试
        let vc = QQScanViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  

}
