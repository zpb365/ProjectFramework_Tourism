//
//  TravelAcyDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/27.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcyDetail: CustomTemplateViewController {
    
    
    
    //用户评论
    lazy var sectionConment:CommentSectionView = {
        let sectionConment = Bundle.main.loadNibNamed("CommentSectionView", owner: self, options: nil)?.last
        return sectionConment as! CommentSectionView
    }()
    //酒店设施那些
    lazy var footderIntroduce: PulickIntroduceView = {
        let footderIntroduce = PulickIntroduceView()
        footderIntroduce.createTableView(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
        footderIntroduce.FuncCallbackValue(value: { [weak self](height) in
            self?.footderHeight = height
            self?.footderIntroduce.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height)
            self?.footderIntroduce.customTableView.frame = (self?.footderIntroduce.bounds)!
            self?.tableView.reloadData()
            
        })
        return footderIntroduce
    }()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var travelAcyName: UILabel!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var pulick: UILabel!
    @IBOutlet weak var phone: UIImageView!
    @IBOutlet weak var tab: UILabel!
    @IBOutlet weak var buttonBar: UIView!
    @IBOutlet weak var name: UILabel!

    
    
    
    let identifier = "UserCommentCell"
    let identFer   = "TravelAcyProductCell"
    let indetifer1 = "cell1"
    let indetifer2 = "cell2"
    
    var CustomNavBar:UINavigationBar!=nil
    var backBtn:UIButton!=nil
    var cellectionBtn:UIButton!=nil
    var shareBtn:UIButton!=nil
    var alph: CGFloat = 0
    var isChange: Bool = false
    var TravelAgencyID=0
    var viewModel = TravelAcyDetailViewModel()
    var cViewModel = CommentViewModel()
    var PageIndex: Int = 1
    var PageSize:  Int = 10
    var ChannelID = 0
    var IntroduceHeight: CGFloat = 10//介绍的高度
    var BookingHeight: CGFloat = 10//预定须知的高度
    var footderHeight: CGFloat = 0//
    
    //MARK: 视图初始化
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavBar()
        self.GetHtpsData()
        self.initUI()
        
    }
    override func viewDidLayoutSubviews() {
        headImage.isUserInteractionEnabled = true
        phone.isUserInteractionEnabled = true
        headImage.tag = 1000
        nextView.tag = 1001
        phone.tag = 1002
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        headImage.addGestureRecognizer(tap1)
        nextView.addGestureRecognizer(tap2)
        phone.addGestureRecognizer(tap3)
    }
    //点击事件
    func tapClick(tap:UITapGestureRecognizer) -> Void {
        switch tap.view!.tag {
            case 1000:
                if (viewModel.ListData.ImageList?.count)! > 0 {
                    var Imagelist = Array<String>()//图片组
                    var ImageTab  = Array<String>()//标签组
                    for i in 0..<(viewModel.ListData.ImageList?.count)!{
                        let model = viewModel.ListData.ImageList?[i]
                        Imagelist.append(HttpsUrlImage+model!.PhotoUrl)
                        ImageTab.append(model!.Tab)
                    }
                    
                    let vc = ImagePreviewViewController( ImageUrlList: Imagelist ,IsDescribe: true,DescribeList: ImageTab )
                    self.navigationController?.pushViewController(vc, animated: true )
                }
            break
            case 1001:
                if (viewModel.ListData.Lng != "" && viewModel.ListData.Lat != ""){
                    var  model  = [MapListModel]()
                    let mapmodel = MapListModel()
                    mapmodel.lat = viewModel.ListData.Lat
                    mapmodel.lng = viewModel.ListData.Lng
                    mapmodel.title = viewModel.ListData.TravelAgencyName
                    model.append(mapmodel)
                    
                    let vc = PublicMapShowListViewController()
                    vc.models=model
                    self.navigationController?.show(vc, sender: self)
                }
            print("跳转到百度地图")
            break
            case 1002:
                if viewModel.ListData.Phone != "" {
                    CommonFunction.CallPhone(self, number: viewModel.ListData.Phone)
                }
            break
            default:
            break
        }

    }
    func setData() -> Void {
        headImage.ImageLoad(PostUrl: HttpsUrlImage+viewModel.ListData.CoverPhoto)
        travelAcyName.text = "  1/\((viewModel.ListData.ImageList?.count)!)"
        adress.text = viewModel.ListData.Address
        tab.text = viewModel.ListData.tab
        pulick.text = "旅游区域： \(viewModel.ListData.TourismScope)"
        name.text = viewModel.ListData.TravelAgencyName
    }
    override func footerRefresh() {
        PageIndex = PageIndex + 1
        self.GetCommentData()
    }
    override func Error_Click() {
        PageIndex = 1
        self.GetHtpsData()
    }
    //MARK: 请求网络数据
    func GetHtpsData() -> Void {
        self.tableViewHead.isHidden = true
        self.sectionConment.isHidden = true
        self.footderIntroduce.isHidden = true
        
        viewModel.GetChannelsTravelAgencyDetails(TravelAgencyID: TravelAgencyID, PageIndex: PageIndex, PageSize: PageSize) { (result) in
            if result == true{
                //没有数据的操作
                if(self.viewModel.ListData.TravelAgencyID == 0){
                    self.numberOfRowsInSection=0
                    self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: false)
                    return
                }
                self.setData()
                self.GetCommentData()
            }else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }

        }
    }
    //MARK: 请求评论数据
    func GetCommentData() -> Void {
        cViewModel.GetAllCommentMsg(ChannelsID: ChannelID, ChannelsListID: TravelAgencyID, PageIndex: PageIndex, PageSize: PageSize) { (result, noMore) in
            if result == true{
                //没有更多数据
                if noMore == true {
                    self.footer.endRefreshingWithNoMoreData()
                }else{
                    self.tableViewHead.isHidden = false
                    self.sectionConment.isHidden = false
                    self.footderIntroduce.isHidden = false
                    self._numberOfRowsInSection[1]=1
                    self._numberOfRowsInSection[2]=1
                    self.RefreshRequest(isLoading: false, isHiddenFooter: false, isLoadError: false)
                    self.footer.endRefreshing()
                }
            }else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    //MARK: tableViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isChange = true
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let offset: CGFloat = scrollView.contentOffset.y
        if (offset <= 64) {
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor().withAlphaComponent(0), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray
            cellectionBtn.backgroundColor = UIColor.gray
            shareBtn.backgroundColor = UIColor.gray
        }
        else{
            alph = 1-((200 - offset)/200)
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor().withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
            cellectionBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
            shareBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
        }
        if (offset > tableViewHead.frame.height - 64 - 40) {
            _ = self.view.subviews.map({
                if(($0.viewWithTag(99)) != nil){
                    return
                }
            })
            self.view.addSubview(buttonBar)
            buttonBar.frame=CGRect(x: 0, y: 64, width: CommonFunction.kScreenWidth, height: 40)
            self.view.bringSubview(toFront: buttonBar)
        }else{
            buttonBar.frame=CGRect(x: 0, y: tableViewHead.frame.height - 40, width: CommonFunction.kScreenWidth, height: 40)
            tableViewHead.addSubview(buttonBar)
            
        }
        
        if isChange {
            if (offset < tableViewHead.frame.height + CGFloat((viewModel.ListData.TravelAgencyProduct?.count)! * 90)) {
                self.btoomLineMove(tag: 1)
            }
            if (offset > CGFloat((viewModel.ListData.TravelAgencyProduct?.count)! * 90) + tableViewHead.frame.height - 104 && offset < CGFloat((viewModel.ListData.TravelAgencyProduct?.count)! * 90) + tableViewHead.frame.height + IntroduceHeight -  104) {
                self.btoomLineMove(tag: 2)
            }
            if (offset > CGFloat((viewModel.ListData.TravelAgencyProduct?.count)! * 90) + tableViewHead.frame.height + IntroduceHeight - 104 && offset < CGFloat((viewModel.ListData.TravelAgencyProduct?.count)! * 90) + tableViewHead.frame.height + IntroduceHeight + BookingHeight - 104) {
                self.btoomLineMove(tag: 3)
            }
            if (offset > CGFloat((viewModel.ListData.TravelAgencyProduct?.count)! * 90) + tableViewHead.frame.height + IntroduceHeight + BookingHeight - 104) {
                self.btoomLineMove(tag: 4)
            }
        }
    }
    func btoomLineMove(tag:Int) -> Void {
        UIView.animate(withDuration: 0.3) {
            let button = self.buttonBar.viewWithTag(tag) as! UIButton
            let line = self.buttonBar.viewWithTag(666)
            line?.center.x = button.center.x
        }
    }
    //组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    var _numberOfRowsInSection = [0,0,0,0]
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if viewModel.ListData.TravelAgencyProduct != nil {
            _numberOfRowsInSection[0] = (viewModel.ListData.TravelAgencyProduct?.count)!
            
        }
        if cViewModel.ListData.count > 0 {
            _numberOfRowsInSection[3] = cViewModel.ListData.count
        }
        return _numberOfRowsInSection[section]
    }
    //组头
    var _viewForHeaderInSection = [UIView(),UIView(),UIView(),UIView()]
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        if (viewModel.ListData.TravelAgencyID != 0){
            _viewForHeaderInSection[1] = UIView().setIntroduceView(height: 40, title: "旅行社简介")
            _viewForHeaderInSection[2] = UIView().setIntroduceView(height: 40, title: "预定须知")
        }
        _viewForHeaderInSection[3] = sectionConment
        sectionConment.setData(scorce: CGFloat(viewModel.ListData.Score), CommentCount: viewModel.ListData.CommentsCount)
        return _viewForHeaderInSection[section]
    }
    // 0产品 1简介 2预定须知 3评论
    var _heightForHeaderInSection = [0,40,40,50]
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return CGFloat(_heightForHeaderInSection[section])
    }
    //组尾
    var isSetData = false
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            if viewModel.ListData.DescribeName != nil {
                if isSetData == false {
                    self.footderIntroduce.setData(object: viewModel.ListData.DescribeName as Any)
                    isSetData = true
                }
                return self.footderIntroduce
            }else{
                return UIView()
            }
        }else{
            return UIView()
            
        }
    }
    //组尾高
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            if viewModel.ListData.DescribeName != nil {
                return self.footderHeight
            }else{
                return 0.0001
            }
        }else{
            return 0.0001
        }
    }
    var _heightForRowAt = [CGFloat(90),CGFloat(0),CGFloat(0),CGFloat(0)]
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        _heightForRowAt[1] = IntroduceHeight > CGFloat(10) ? IntroduceHeight :CGFloat(0)
        _heightForRowAt[2] = BookingHeight > CGFloat(10) ? BookingHeight :CGFloat(0)
        if cViewModel.ListData.count > 0 && indexPath.section == 3{
            let model = cViewModel.ListData[indexPath.row]
            _heightForRowAt[3] = self.tableView.getHeightWithCell(lableWidth: CommonFunction.kScreenWidth - 35, commont: model.ContentMsg, imageArray: [], showCount: (model.Photos?.count)!, rowCount: 3, contenViewWidth: CommonFunction.kScreenWidth - 35, xMargin: 10, yMargin: 10) + 48 + 10
        }
        return _heightForRowAt[indexPath.section]

    }
    //数据源
    var isfirst1: Bool = false
    var isfirst2: Bool = false
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: identFer, for:indexPath) as! TravelAcyProductCell
            cell.InitConfig(viewModel.ListData.TravelAgencyProduct?[indexPath.row] as Any)
            cell.FuncCallbackValue(value: {[weak self] (str) in
                let vc = TravelAcyDateChoose()
                vc.travelProduct = self?.viewModel.ListData.TravelAgencyProduct?[indexPath.row]
                self?.navigationController?.show(vc, sender: self)

            })
            return cell
        }
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: indetifer1, for: indexPath)as!PulickWebCell
            if viewModel.ListData.Introduce != "" {
                cell.loadHtmlString(html: viewModel.ListData.Introduce, isFirst: isfirst1)
                isfirst1 = true
                cell.FuncCallbackValue(value: {[weak self] (height) in
                    print("介绍高度",height)
                    self?.IntroduceHeight = height
                    self?.tableView.reloadData()
                })
            }
            return cell
        }
        if (indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: indetifer2, for: indexPath)as!PulickWebCell
            if viewModel.ListData.BookInformation != "" {
                cell.loadHtmlString(html: viewModel.ListData.BookInformation, isFirst: isfirst2)
                isfirst2 = true
                cell.FuncCallbackValue(value: {[weak self] (height) in
                    print("预定须知高度",height)
                    self?.BookingHeight = height
                    self?.tableView.reloadData()
                })
            }
            return cell
        }
        if (indexPath.section == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! UserCommentCell
            cell.InitConfig(cViewModel.ListData[indexPath.row] as Any)
            return cell

        }
        else{
            return UITableViewCell()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = CommonFunction.ViewControllerWithStoryboardName("TravelAcyRoute", Identifier: "TravelAcyRoute") as! TravelAcyRoute
            vc.travelProduct = viewModel.ListData.TravelAgencyProduct?[indexPath.row]
            self.navigationController?.show(vc, sender: self)
        }
    }
    //MARK: initUI
    func initUI() -> Void {
        
        //悬浮条
        let titleArray: Array=["旅游产品","旅行社简介","预定须知","用户点评"]
        for i in 0..<titleArray.count {
            let title = titleArray[i]
            let button = UIButton.init(type: .system)
            let frame_x = CGFloat((CommonFunction.kScreenWidth/CGFloat(titleArray.count))*CGFloat(i))
            button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:CommonFunction.kScreenWidth / CGFloat(titleArray.count) , h: 35)
            button.tag = 1 + i
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.black, for: .normal)
            button.addTarget(self, action:#selector(headerClick), for: .touchUpInside)
            button.adjustsImageWhenHighlighted = false
            if (i == 0) {
                let bottomLine = UIView()
                
                bottomLine.tag = 666
                bottomLine.frame = CommonFunction.CGRect_fram(0, y: 35, w: 60, h: 3)
                bottomLine.center.x = button.center.x
                bottomLine.backgroundColor = UIColor().TransferStringToColor("#03A9F4")
                buttonBar.addSubview(bottomLine)
            }
            buttonBar.addSubview(button)
        }
        
        //tableViewInit
        self.InitCongif(tableView)
        self.header.isHidden = true
        self.tableView.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight )
        self.tableView.tableHeaderView = self.tableViewHead
        self.tableView.register(UserCommentCell.self, forCellReuseIdentifier: identifier)
        self.tableView.register(PulickWebCell.self, forCellReuseIdentifier: indetifer1)
        self.tableView.register(PulickWebCell.self, forCellReuseIdentifier: indetifer2)
    }
    //悬浮条按钮方法
    func headerClick(_ button: UIButton) -> Void {
        isChange = false
        //底部线滑动
        UIView.animate(withDuration: 0.3) {
            let line = self.buttonBar.viewWithTag(666)
            line?.center.x = button.center.x
        }
        if (button.tag == 1) {
            
            self.tableView.setContentOffset(CGPoint.init(x: 0, y: tableViewHead.frame.height - 104), animated: true)
        }
        if button.tag - 1 == 3 {
            if cViewModel.ListData.count == 0 {
                self.tableView.setContentOffset(CGPoint.init(x: 0, y: CGFloat((viewModel.ListData.TravelAgencyProduct?.count)! * 90) + tableViewHead.frame.height + IntroduceHeight + BookingHeight + 80 + footderHeight), animated: true)
            }else{
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: button.tag - 1), at: .middle, animated: true)
            }
        }else{
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: button.tag - 1), at: .middle, animated: true)
        }

    }

    //MARK: 设置导航栏
    func setNavBar() -> Void {
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor().withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
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
//        CustomNavItem.rightBarButtonItems=[UIBarButtonItem.init(customView: shareBtn),UIBarButtonItem.init(customView: cellectionBtn)]
        
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
            print("购买")
            break
        default:
            break
        }
        
    }
    

}
