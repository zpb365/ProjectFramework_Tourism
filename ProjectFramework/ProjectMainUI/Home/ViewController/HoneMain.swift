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
    
    fileprivate let viewModel = HomeViewModel()
    
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
    
    var titleArray=[String]()
    var HeadShowCountArray=[Int]()
    var currentHeadlinesBtn = UIButton() //智慧头条
    lazy var SectionHeadlinesButtonBar: UIView = {
        let topButtonBar = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 25, w: CommonFunction.kScreenWidth, h: 40))
        topButtonBar.backgroundColor = UIColor.white
   
        for i in 0..<self.titleArray.count {
            let title = self.titleArray[i]
            let button = UIButton.init(type: .system)
            let frame_x = CGFloat((CommonFunction.kScreenWidth/CGFloat(self.titleArray.count))*CGFloat(i))
            button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:CommonFunction.kScreenWidth / CGFloat(self.titleArray.count) , h: 35)
            button.tag =  i
            button.ExpTagString=title
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
                        self?.tableView.reloadData()
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
    var VisualShowCountArray=[Int]()
    lazy var SectionVisualButtonBar: UIView = {
        let topButtonBar = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 25, w: CommonFunction.kScreenWidth, h: 40))
        topButtonBar.backgroundColor = UIColor.white
        let titleArray: Array=["美图","全景","VR视频"]
        for i in 0..<titleArray.count {
            let title = titleArray[i]
            let button = UIButton.init(type: .system)
            let frame_x = CGFloat((CommonFunction.kScreenWidth/CGFloat(titleArray.count))*CGFloat(i))
            button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:CommonFunction.kScreenWidth / CGFloat(titleArray.count) , h: 35)
            button.tag =  i
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.ExpTagString=title
            button.rx.tap.subscribe(
                onNext:{ [weak self] value in
                    UIView.animate(withDuration: 0.3) { //点击滑动绑定事件
                        let line = self?.SectionVisualButtonBar.viewWithTag(666)
                        line?.center.x = button.center.x
                        button.setTitleColor(CommonFunction.SystemColor(), for: .normal)
                        self?.currentVisualBtn.setTitleColor(UIColor.gray, for: .normal)
                        self?.currentVisualBtn = button
                        self?.tableView.reloadData()
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
        self.header.isHidden=true
        tableView.frame=CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-(CommonFunction.NavigationControllerHeight+49))
        self.InitCongif(tableView)
        SetupNavBar()
        GetHtpsData()
    }
    
    func GetHtpsData(){
         self.RefreshRequest(isLoading: true,isHiddenFooter: true)
        //获取网络数据
        viewModel.GetHomeInfo { (relust) in
            if(relust==true){   //数据请求成功
                self.numberOfSections=10
                for i in 0..<self.viewModel.ListData.NewsList!.count {  //设置智慧头条的选项名称
                    self.titleArray.append(self.viewModel.ListData.NewsList![i].NewsTypeName)  //添加到当前数据列
                    self.HeadShowCountArray.append(self.viewModel.ListData.NewsList![i].List!.count)    // 添加当前索引的总数（用用滑动刷新展示不同数据列)
                }
                //设置视觉盛宴的总数 -->美图
                self.VisualShowCountArray.append(self.viewModel.ListData.VisualFeast!.BeautifulPictureList!.count)    // 添加当前索引的总数（用用滑动刷新展示不同数据列)
                //设置视觉盛宴的总数  --> 全景
                self.VisualShowCountArray.append(self.viewModel.ListData.VisualFeast!.Panorama360List!.count)    // 添加当前索引的总数（用用滑动刷新展示不同数据列)
                //设置视觉盛宴的总数  --> VR视频
                self.VisualShowCountArray.append(self.viewModel.ListData.VisualFeast!.VRVideoDTO!.count)    // 添加当前索引的总数（用用滑动刷新展示不同数据列)
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                
                self.InitAdv(ClassAdvList: self.viewModel.ListData.advList!)
                
            }else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true) 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return HeadShowCountArray[currentHeadlinesBtn.tag] //智慧头条
        case 1: return 1    //热门推荐
        case 2: return Int((CGFloat(VisualShowCountArray[currentVisualBtn.tag]) / 3.0).description.components(separatedBy: ".")[1])! > 0 ? (VisualShowCountArray[currentVisualBtn.tag]/3)+1:VisualShowCountArray[currentVisualBtn.tag]/3   //视觉盛宴
        case 3: return Int((CGFloat(self.viewModel.ListData.Scenic!.count) / 3.0).description.components(separatedBy: ".")[1])! > 0 ? (self.viewModel.ListData.Scenic!.count/3)+1:self.viewModel.ListData.Scenic!.count/3   //景区
        case 4: return Int((CGFloat(self.viewModel.ListData.Hotel!.count) / 2.0).description.components(separatedBy: ".")[1])! > 0 ? (self.viewModel.ListData.Hotel!.count/2)+1:self.viewModel.ListData.Hotel!.count/2   //酒店
        case 5: return Int((CGFloat(self.viewModel.ListData.Restaurant!.count) / 3.0).description.components(separatedBy: ".")[1])! > 0 ? (self.viewModel.ListData.Restaurant!.count/3)+1:self.viewModel.ListData.Restaurant!.count/3     //餐厅
        case 6: return Int((CGFloat(self.viewModel.ListData.TravelAgency!.count) / 2.0).description.components(separatedBy: ".")[1])! > 0 ? (self.viewModel.ListData.TravelAgency!.count/2)+1:self.viewModel.ListData.TravelAgency!.count/2  //旅行社
        case 7: return Int((CGFloat(self.viewModel.ListData.Meeting!.count) / 3.0).description.components(separatedBy: ".")[1])! > 0 ? (self.viewModel.ListData.Meeting!.count/3)+1:self.viewModel.ListData.Meeting!.count/3   //会展
        case 8: return Int((CGFloat(self.viewModel.ListData.Specialities!.count) / 2.0).description.components(separatedBy: ".")[1])! > 0 ? (self.viewModel.ListData.Specialities!.count/2)+1:self.viewModel.ListData.Specialities!.count/2  //特产
        case 9: return self.viewModel.ListData.Travels!.count   //游记攻略
        default:
            break
        }
         return 0
    }
    
    let _heightForHeaderInSection=[60,40,60,40,40,40,40,40,40,40]   //行头部高度
    let _heightForHeaderInSectionText=["智慧头条","热门推荐","视觉盛宴","景区","酒店","餐厅","旅行社","会展","特产","游记攻略"]   //行头部文本
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat(_heightForHeaderInSection[section])
    }
    
    let _heightForRowAt=[55,105,100,100,150,115,150,115,150,80]  //行高
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
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! HeadlinesViewCell   //头条
            cell.InitConfig(viewModel.ListData.NewsList?[currentHeadlinesBtn.tag].List?[indexPath.row] as Any)
            return  cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! RecommendedViewCell //推荐
            cell.delegate = self
            cell.InitConfig(viewModel.ListData.HotList as Any)
            return  cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! VisualViewCell
            cell.BeautifulPictureList.removeAll()
            cell.Panorama360List.removeAll()
            cell.VRVideoClassList.removeAll()
            cell.delegate=self
            if(currentVisualBtn.tag==0){    //点击美图
                if( viewModel.ListData.VisualFeast!.BeautifulPictureList!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                cell.BeautifulPictureList.append(viewModel.ListData.VisualFeast!.BeautifulPictureList![indexPath.row*3+0])
                }
                if( viewModel.ListData.VisualFeast!.BeautifulPictureList!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                cell.BeautifulPictureList.append(viewModel.ListData.VisualFeast!.BeautifulPictureList![indexPath.row*3+1])
                }
                if( viewModel.ListData.VisualFeast!.BeautifulPictureList!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                cell.BeautifulPictureList.append(viewModel.ListData.VisualFeast!.BeautifulPictureList![indexPath.row*3+2])
                }
            }
            if(currentVisualBtn.tag==1){    //点击全景
                if( viewModel.ListData.VisualFeast!.Panorama360List!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                cell.Panorama360List.append(viewModel.ListData.VisualFeast!.Panorama360List![indexPath.row*3+0])
                }
                if( viewModel.ListData.VisualFeast!.Panorama360List!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                cell.Panorama360List.append(viewModel.ListData.VisualFeast!.Panorama360List![indexPath.row*3+1])
                }
                if( viewModel.ListData.VisualFeast!.Panorama360List!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                cell.Panorama360List.append(viewModel.ListData.VisualFeast!.Panorama360List![indexPath.row*3+2])
                }
            }
            if(currentVisualBtn.tag==2){    //点击视频
                if( viewModel.ListData.VisualFeast!.VRVideoDTO!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                    cell.VRVideoClassList.append( viewModel.ListData.VisualFeast!.VRVideoDTO![indexPath.row*3+0])
                }
                if( viewModel.ListData.VisualFeast!.VRVideoDTO!.count > (indexPath.row*3+1)  ){    //判断元素 否则就越界了 出错
                    cell.VRVideoClassList.append( viewModel.ListData.VisualFeast!.VRVideoDTO![indexPath.row*3+1])
                }
                if( viewModel.ListData.VisualFeast!.VRVideoDTO!.count  > (indexPath.row*3+2)  ){   //判断元素 否则就越界了 出错
                     cell.VRVideoClassList.append( viewModel.ListData.VisualFeast!.VRVideoDTO![indexPath.row*3+2])
                } 
            }
            cell.InitConfig("") 
            return  cell    //视觉盛宴
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! ScenicViewCell    //景区
            cell.Scenic.removeAll()
            cell.delegate=self
            if( viewModel.ListData.Scenic!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                cell.Scenic.append( viewModel.ListData.Scenic![indexPath.row*3+0])
            }
            if( viewModel.ListData.Scenic!.count > (indexPath.row*3+1)  ){    //判断元素 否则就越界了 出错
                cell.Scenic.append( viewModel.ListData.Scenic![indexPath.row*3+1])
            }
            if( viewModel.ListData.Scenic!.count  > (indexPath.row*3+2)  ){   //判断元素 否则就越界了 出错
                cell.Scenic.append( viewModel.ListData.Scenic![indexPath.row*3+2])
            }
            cell.InitConfig("")
            return  cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! HotelViewCell //酒店
            cell.Hotel.removeAll()
            cell.delegate=self
            if( viewModel.ListData.Hotel!.count > (indexPath.row*2+0)  ){  //判断元素 否则就越界了 出错
                cell.Hotel.append( viewModel.ListData.Hotel![indexPath.row*2+0])
            }
            if( viewModel.ListData.Hotel!.count > (indexPath.row*2+1)  ){    //判断元素 否则就越界了 出错
                cell.Hotel.append( viewModel.ListData.Hotel![indexPath.row*2+1])
            }
            cell.InitConfig("")
            
            return  cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! RestaurantViewCell  //餐厅
            cell.Restaurant.removeAll()
            cell.delegate=self
            if( viewModel.ListData.Restaurant!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                cell.Restaurant.append( viewModel.ListData.Restaurant![indexPath.row*3+0])
            }
            if( viewModel.ListData.Restaurant!.count > (indexPath.row*3+1)  ){    //判断元素 否则就越界了 出错
                cell.Restaurant.append( viewModel.ListData.Restaurant![indexPath.row*3+1])
            }
            if( viewModel.ListData.Restaurant!.count > (indexPath.row*3+2)  ){    //判断元素 否则就越界了 出错
                cell.Restaurant.append( viewModel.ListData.Restaurant![indexPath.row*3+2])
            }
            cell.InitConfig("")
            return  cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! TravelAcyViewCell //旅行社
            cell.TravelAgency.removeAll()
            cell.delegate=self
            if( viewModel.ListData.TravelAgency!.count > (indexPath.row*2+0)  ){  //判断元素 否则就越界了 出错
                cell.TravelAgency.append( viewModel.ListData.TravelAgency![indexPath.row*2+0])
            }
            if( viewModel.ListData.TravelAgency!.count > (indexPath.row*2+1)  ){    //判断元素 否则就越界了 出错
                cell.TravelAgency.append( viewModel.ListData.TravelAgency![indexPath.row*2+1])
            }
            cell.InitConfig("")
            return  cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! MeetingViewCell  //会展
            cell.Meeting.removeAll()
            cell.delegate=self
            if( viewModel.ListData.Meeting!.count > (indexPath.row*3+0)  ){  //判断元素 否则就越界了 出错
                cell.Meeting.append( viewModel.ListData.Meeting![indexPath.row*3+0])
            }
            if( viewModel.ListData.Meeting!.count > (indexPath.row*3+1)  ){    //判断元素 否则就越界了 出错
                cell.Meeting.append( viewModel.ListData.Meeting![indexPath.row*3+1])
            }
            if( viewModel.ListData.Meeting!.count > (indexPath.row*3+2)  ){    //判断元素 否则就越界了 出错
                cell.Meeting.append( viewModel.ListData.Meeting![indexPath.row*3+2])
            }
            cell.InitConfig("")
            return  cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! SpecialtyViewCell   //特产
            cell.Specialities.removeAll()
            cell.delegate=self
            if( viewModel.ListData.Specialities!.count > (indexPath.row*2+0)  ){  //判断元素 否则就越界了 出错
                cell.Specialities.append( viewModel.ListData.Specialities![indexPath.row*2+0])
            }
            if( viewModel.ListData.Specialities!.count > (indexPath.row*2+1)  ){    //判断元素 否则就越界了 出错
                cell.Specialities.append( viewModel.ListData.Specialities![indexPath.row*2+1])
            }
            cell.InitConfig("")
            return  cell
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier[indexPath.section], for: indexPath) as! TravelGuideViewCell   //游记
            cell.InitConfig(viewModel.ListData.Travels[indexPath.row])
            cell.delegate=self
            return  cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case  0:
            let vc = InformationViewController()    //点击智慧头条的cell
            vc.title=viewModel.ListData.NewsList![currentHeadlinesBtn.tag].List![indexPath.row].Title
            vc.Content = viewModel.ListData.NewsList![currentHeadlinesBtn.tag].List![indexPath.row].NewsContent
            self.navigationController?.show(vc, sender: self)
            break
        case 9 :    //游记
            let vc = CommonFunction.ViewControllerWithStoryboardName("TravelDetail", Identifier: "TravelDetail") as! TravelDetail
            vc.TravelsId=viewModel.ListData.Travels[indexPath.row].TravelsId
            self.navigationController?.show(vc, sender: self  )
            break
        default:
            break
        }
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
    private func InitAdv(ClassAdvList:[ClassAdvList]){
        
        var Imagelist  =  [String]()
        for var item in ClassAdvList{
            Imagelist.append(item.Img)
        }
        let vc = ScrollViewPageViewController(Enabletimer: true,   //是否启动滚动
            timerInterval: 4,     //如果启用滚动，滚动秒数
            ImageList:Imagelist  ,//图片
            frame: Adv_View.frame,
            Callback_SelectedValue: { (index, istrue) in
                if ClassAdvList[index].LinkUrl != ""{
                    let vc = MCWebViewController.init(url: ClassAdvList[index].LinkUrl, ProcesscColor: UIColor.clear)
                    self.navigationController?.show(vc, sender: self)
                }
                print(index,istrue)
        } ,
            isJumpBtn: nil,
            Callback_JumpValue: nil)
        
        Adv_View.addSubview(vc.view)
        
       
    }
    
    ///数据请求出错了处理事件
    override func Error_Click() {
        GetHtpsData()
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
        let vc = CommonFunction.ViewControllerWithStoryboardName("SearchProductViewController", Identifier: "SearchProductViewController") as! SearchProductViewController
        vc.SearchTitle=searchText!
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
