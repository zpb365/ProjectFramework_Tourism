//
//  HotelDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/21.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HotelDetail: CustomTemplateViewController {
    
    
    lazy var sectionDate:DateSectionView = {
        let sectionDate = Bundle.main.loadNibNamed("DateSectionView", owner: self, options: nil)?.last
        return sectionDate as! DateSectionView
        
    }()
    lazy var sectionConment:CommentSectionView = {
        let sectionConment = Bundle.main.loadNibNamed("CommentSectionView", owner: self, options: nil)?.last
        
        return sectionConment as! CommentSectionView
    }()
    //酒店设施那些
    lazy var footderIntroduce: PulickIntroduceView = {
        let footderIntroduce = PulickIntroduceView()
        footderIntroduce.createTableView(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
        footderIntroduce.FuncCallbackValue(value: { [weak self](height) in
            self?.footderIntroduceHeght = height
            self?.footderIntroduce.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height)
            self?.footderIntroduce.customTableView.frame = (self?.footderIntroduce.bounds)!
            self?.tableView.reloadData()
            
        })
        return footderIntroduce
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!//头部视图
    @IBOutlet weak var ReserveCount: UILabel!//今天酒店的预定数
    @IBOutlet weak var buttonBar: UIView!
    @IBOutlet weak var headimage: UIImageView!//头部图片
    @IBOutlet weak var address: UIView!//头部地址
    @IBOutlet weak var phone: UIImageView!//头部电话
    @IBOutlet weak var VRVedio: UIView!//头部VR视频
    @IBOutlet weak var hotelTilte: UILabel!//标题
    @IBOutlet weak var hotelAdress: UILabel!//地址
    @IBOutlet weak var hotelTab: UILabel!//标签
    
    let identiFier = "HotelRoomReserveCell"
    let identifier = "UserCommentCell"
    let indetifer1 = "cell1"
    let indetifer2 = "cell2"
    
    
    var CustomNavBar:UINavigationBar!=nil
    var backBtn:UIButton!=nil
    var cellectionBtn:UIButton!=nil
    var shareBtn:UIButton!=nil
    var alph: CGFloat = 0
    var hotelIntroduceHeight: CGFloat = 50//酒店介绍的高度
    var BookingHeight: CGFloat = 50//预定须知的高度
    var footderIntroduceHeght: CGFloat = 50//酒店设施那些
    var isChange: Bool = false//防止tableView重复滑动的标记
    var ChannelID=0
    var viewModel = HotelDetailViewModel()
    var cViewModel = CommentViewModel()
    var PageIndex: Int      = 1
    var PageSize:  Int      = 10
    var HotelID = 0
    var DateTimeBegin = ""
    var DateTimeEnd = ""
    var startYear=0
    var startMoon=0
    var startDay=0
    var endYear=0
    var endMoon=0
    var endDay=0
    var totalNumber = 0
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#5E7D8A"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.getDate()
        self.setNavBar()
        self.setHeadView()
        self.GetHtpsData()
        self.initUI()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        ReserveCount.layer.cornerRadius = 4
        ReserveCount.clipsToBounds = true
        
        //--------------------------------给头部视图添加点击事件--------------------------------
        headimage.tag = 1000
        address.tag = 1001
        phone.tag = 1002
        VRVedio.tag = 1003
        headimage.isUserInteractionEnabled = true
        phone.isUserInteractionEnabled = true
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        let tap4 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        headimage.addGestureRecognizer(tap1)
        address.addGestureRecognizer(tap2)
        phone.addGestureRecognizer(tap3)
        VRVedio.addGestureRecognizer(tap4)
        //组头的日期增加点击事件
        sectionDate.startButon.addTarget(self, action: #selector(goDateChoose), for: .touchUpInside)
        sectionDate.endButton.addTarget(self, action: #selector(goDateChoose), for: .touchUpInside)
    }
    //MARK: 跳转去时间选择
    func goDateChoose() -> Void {
        let vc = ZFChooseTimeViewController()
        vc.backDate {[weak self] (goDate, backDate) in
//            print("-----",goDate as Any,"++++++",backDate as Any)
            self?.DateTimeBegin = "\(goDate![0])-\(goDate![1])-\(goDate![2])"
            self?.DateTimeEnd = "\(backDate![0])-\(backDate![1])-\(backDate![2])"
            self?.startYear  = Int((goDate?[0] as AnyObject ).int32Value)
            self?.startMoon = Int((goDate?[1] as AnyObject ).int32Value)
            self?.startDay  = Int((goDate?[2] as AnyObject ).int32Value)
            self?.endYear   = Int((backDate?[0] as AnyObject ).int32Value)
            self?.endMoon   = Int((backDate?[1] as AnyObject ).int32Value)
            self?.endDay    = Int((backDate?[2] as AnyObject ).int32Value)
            self?.GetHotelDetailsProduct()
        }
        self.navigationController?.show(vc, sender: self  )
    }
    //MARK: getDate
    func getDate() -> Void {
        //获取今天日期
        let nowDate = DateClass.getNowDate()
        let tomorrowDate = DateClass.getTomorrowDay(NSDate.init() as Date)
        DateTimeBegin = "\(nowDate.year)-\(nowDate.month)-\(nowDate.day)"
        DateTimeEnd   = "\(tomorrowDate.year)-\(tomorrowDate.month)-\(tomorrowDate.day)"
        startYear = nowDate.year
        startMoon = nowDate.month
        startDay  = nowDate.day
        endDay    = tomorrowDate.day
        endMoon   = tomorrowDate.month
        endYear   = tomorrowDate.year
    }
    //获取日期产品
    func GetHotelDetailsProduct() -> Void {
        viewModel.GetHotelDetailsProduct(HotelID: HotelID, DateTimeBegin: DateTimeBegin, DateTimeEnd: DateTimeEnd) { (result) in
            if result == true{
                self.RefreshRequest(isLoading: false, isHiddenFooter: false)
            }
            else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    override func Error_Click() {
        PageIndex = 1
        self.GetHtpsData()
    }
    override func footerRefresh() {
        PageIndex = PageIndex + 1
        self.GetCommentData()
    }
    //MARK: 请求数据
    func GetHtpsData() -> Void {
        self.tableViewHead.isHidden = true
        self.sectionDate.isHidden = true
        self.sectionConment.isHidden = true
        self.footderIntroduce.isHidden = true
        viewModel.GetChannelsHotelDetails(HotelID: HotelID, PageIndex: PageIndex, PageSize: PageSize, DateTimeBegin: DateTimeBegin, DateTimeEnd: DateTimeEnd) { (result) in
            if result == true{
                //没有数据的操作
                if(self.viewModel.ListData.HotelID == 0){
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
        cViewModel.GetAllCommentMsg(ChannelsID: ChannelID, ChannelsListID: HotelID, PageIndex: PageIndex, PageSize: PageSize) { (result, noMore) in
            self.footer.endRefreshing()
            
            if result == true{
                //没有更多数据
                if noMore == true {
                    self.footer.endRefreshingWithNoMoreData()
                }else{
                    
                    self.tableViewHead.isHidden = false
                    self.sectionDate.isHidden = false
                    self.sectionConment.isHidden = false
                    self.footderIntroduce.isHidden = false
                    self._numberOfRowsInSection[1]=1
                    self._numberOfRowsInSection[2]=1
                    self.RefreshRequest(isLoading: false, isHiddenFooter: false, isLoadError: false)
                }
                
            }else{
                
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }

    func setData() -> Void {
        hotelTilte.text = " 1/\(viewModel.ListData.ImageList!.count) \(viewModel.ListData.HotelName)"
        headimage.ImageLoad(PostUrl: HttpsUrlImage+viewModel.ListData.CoverPhoto)
        hotelAdress.text = viewModel.ListData.Address
        hotelTab.text   = viewModel.ListData.tab
        ReserveCount.text = viewModel.ListData.ToDayOrderNumber
        
        self.RefreshRequest(isLoading: false, isHiddenFooter: false)
    }
    
    //MARK: initUI
    func initUI() -> Void {
        
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y:0, w: self.view.frame.width, h: self.view.frame.height)
        self.tableView.tableHeaderView = tableViewHead
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 0.001))
        self.header.isHidden = true
        self.tableView.register(UserCommentCell.self, forCellReuseIdentifier: identifier)
        self.tableView.register(PulickWebCell.self, forCellReuseIdentifier: indetifer1)
        self.tableView.register(PulickWebCell.self, forCellReuseIdentifier: indetifer2)
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets.zero
        }
        if tableView.responds(to:#selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets.zero
        }
    }
    func tapClick(tap:UITapGestureRecognizer) -> Void {
        switch tap.view!.tag {
        case 1000:
            if (viewModel.ListData.ImageList?.count)! > 0 {
                var Imagelist = Array<String>()//图片组
                var ImageTab  = Array<String>()//标签组
                for i in 0..<(viewModel.ListData.ImageList?.count)!{
                    let model = viewModel.ListData.ImageList?[i]
                    Imagelist.append(HttpsUrlImage+model!.PhotoUrl)
                    ImageTab.append(model!.PhotoDescribe)
                }
                
                let vc = ImagePreviewViewController( ImageUrlList: Imagelist ,IsDescribe: true,DescribeList: ImageTab )
                self.navigationController?.pushViewController(vc, animated: true )
            }

        case 1001:
            if (viewModel.ListData.Lng != "" && viewModel.ListData.Lat != ""){
                var  model  = [MapListModel]()
                let mapmodel = MapListModel()
                mapmodel.lat = viewModel.ListData.Lat
                mapmodel.lng = viewModel.ListData.Lng
                mapmodel.title = viewModel.ListData.HotelName
                model.append(mapmodel)
                
                let vc = PublicMapShowListViewController()
                vc.models=model
                self.navigationController?.show(vc, sender: self)
            }
            
        case 1002:
            if viewModel.ListData.Phone != "" {
                CommonFunction.CallPhone(self, number: viewModel.ListData.Phone)
            }
        case 1003:
            if viewModel.ListData.Panorama360 != nil {
                let vc = Public360ViewController()
                vc.url = HttpsPanorama360+(viewModel.ListData.Panorama360?.description)!
                self.present(vc, animated: true, completion:nil)
            }
            
        default:
            break
        }
    }
    //MARK: 设置导航栏
    func setNavBar() -> Void {
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#5E7D8A").withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
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
    //MARK: 设置头部
    func setHeadView() -> Void {
        let titleArray: Array=["预定酒店","酒店简介","预定须知","用户点评"]
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
                bottomLine.frame = CommonFunction.CGRect_fram(0, y: 35, w: 70, h: 3)
                bottomLine.center.x = button.center.x
                bottomLine.backgroundColor = UIColor().TransferStringToColor("#03A9F4")
                buttonBar.addSubview(bottomLine)
            }
            buttonBar.addSubview(button)
        }
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
        default:
            break
        }
        
    }
    //MARK: 组头按钮方法
    func headerClick(_ button: UIButton) {
        isChange = false
        //底部线滑动
        UIView.animate(withDuration: 0.3) {
            let line = self.buttonBar.viewWithTag(666)
            line?.center.x = button.center.x
        }
        //  1 预定酒店   2 酒店简介  3 预定须知  4 用户点评
        if button.tag - 1 == 0 {
            
                self.tableView.setContentOffset(CGPoint.init(x: 0, y: tableViewHead.frame.height - 104), animated: true)
        }else{
            if button.tag - 1 == 3 {
                if viewModel.ListData.CommentMes!.count == 0 {
                    self.tableView.setContentOffset(CGPoint.init(x: 0, y: CGFloat(viewModel.ListData.HotelProduct!.count * 80) + tableViewHead.frame.height + hotelIntroduceHeight + BookingHeight + 80 + footderIntroduceHeght), animated: true)
                }else{
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: button.tag - 1), at: .middle, animated: true)
                }
            }else{
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: button.tag - 1), at: .middle, animated: true)
            }
        }
        
    }
    //MARK: tableViewDelegate
    //MARK: 开始拖动时调用的方法
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isChange = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let offset: CGFloat = scrollView.contentOffset.y
        if (offset <= 64) {
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#5E7D8A").withAlphaComponent(0), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray
            cellectionBtn.backgroundColor = UIColor.gray
            shareBtn.backgroundColor = UIColor.gray
        }
        else{
            alph = 1-((200 - offset)/200)
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#5E7D8A").withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
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
            buttonBar.frame=CGRect(x: 0, y: 330, width: CommonFunction.kScreenWidth, height: 40)
            tableViewHead.addSubview(buttonBar)
            
        }
        //顶部按钮线移动
        if isChange {
            if (offset < CGFloat(viewModel.ListData.HotelProduct!.count * 80) + tableViewHead.frame.height) {
                self.btoomLineMove(tag: 1)
            }
            if (offset > CGFloat(viewModel.ListData.HotelProduct!.count * 80) + tableViewHead.frame.height && offset < 10 * 80 + tableViewHead.frame.height + hotelIntroduceHeight + 40 + footderIntroduceHeght) {
                self.btoomLineMove(tag: 2)
            }
            if (offset > CGFloat(viewModel.ListData.HotelProduct!.count * 80) + tableViewHead.frame.height + hotelIntroduceHeight + 40 + footderIntroduceHeght && offset < 10 * 80 + tableViewHead.frame.height + hotelIntroduceHeight + BookingHeight + 80 + footderIntroduceHeght) {
                self.btoomLineMove(tag: 3)
            }
            if (offset > CGFloat(viewModel.ListData.HotelProduct!.count * 80) + tableViewHead.frame.height + hotelIntroduceHeight + BookingHeight + 80 + footderIntroduceHeght){
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
    var _viewForHeaderInSection = [UIView(),UIView(),UIView(),UIView()]
    //组头
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        _viewForHeaderInSection[0] = sectionDate
        self.totalNumber = sectionDate.setDate(startYear: startYear, startMoon: startMoon, startDay: startDay, endYear: endYear, endMoon: endMoon, endDay: endDay)
        if viewModel.ListData.HotelID != 0 {
            _viewForHeaderInSection[1] = UIView().setIntroduceView(height: 40, title: "酒店介绍")
            _viewForHeaderInSection[2] = UIView().setIntroduceView(height: 40, title: "预定须知")
        }
        _viewForHeaderInSection[3] = sectionConment
        sectionConment.setData(scorce: CGFloat(viewModel.ListData.Score), CommentCount: viewModel.ListData.CommentsCount)
        return _viewForHeaderInSection[section]
    }
    var _heightForHeaderInSection = [40,40,40,50]
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
                return self.footderIntroduceHeght
            }else{
                return 0.0001
            }
        }else{
            return 0.0001
        }
    }
    var _numberOfRowsInSection = [0,0,0,0]
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //防崩溃
        if viewModel.ListData.HotelProduct != nil && section == 0{
                _numberOfRowsInSection[0] = (viewModel.ListData.HotelProduct?.count)!
        }
        if cViewModel.ListData.count > 0 {
            _numberOfRowsInSection[3] = cViewModel.ListData.count
        }
        return _numberOfRowsInSection[section]
        
    }
    var _heightForRowAt = [CGFloat(80),CGFloat(0),CGFloat(0),CGFloat(0)]
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        _heightForRowAt[1] = hotelIntroduceHeight > CGFloat(50) ? hotelIntroduceHeight : CGFloat(50)
        _heightForRowAt[2] = BookingHeight > CGFloat(50) ? BookingHeight : CGFloat(50)
        if viewModel.ListData.CommentMes != nil && indexPath.section == 3 {
            if cViewModel.ListData.count > 0 && indexPath.section == 3{
                let model = cViewModel.ListData[indexPath.row]
                _heightForRowAt[3] = self.tableView.getHeightWithCell(lableWidth: CommonFunction.kScreenWidth - 35, commont: model.ContentMsg, imageArray: [], showCount: (model.Photos?.count)!, rowCount: 3, contenViewWidth: CommonFunction.kScreenWidth - 35, xMargin: 10, yMargin: 10) + 48 + 10
            }
        }
        return _heightForRowAt[indexPath.section]
    }
    //数据源
    var isfirst1: Bool = false
    var isfirst2: Bool = false
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! HotelRoomReserveCell
            if viewModel.ListData.HotelProduct!.count > 0 && viewModel.ListData.HotelProduct != nil {
                cell.InitConfig(viewModel.ListData.HotelProduct?[indexPath.row] as Any)
                //检测是否有库存
                    cell.FuncCallbackValue(value: {[weak self] (str) in
                        if self?.viewModel.ListData.HotelProduct?[indexPath.row].IsInventory == true{
                            let vc = CommonFunction.ViewControllerWithStoryboardName("HotelOderWrite", Identifier: "HotelOderWrite") as! HotelOderWrite
                            vc.HotelProduct = self?.viewModel.ListData.HotelProduct?[indexPath.row]
                            vc.totalNumber  = (self?.totalNumber)!
                            vc.text         = "\((self!.startMoon))月\(self!.startDay)日 - \(self!.endMoon)月\(self!.endDay)日"
                            vc.DateTimeBegin = (self?.DateTimeBegin)!
                            vc.DateTimeEnd = (self?.DateTimeEnd)!
                            self?.navigationController?.show(vc, sender: self  )
                        }else{
                            CommonFunction.HUD("该产品暂无库存！", type: .error)
                        }
                    })

            }
            return cell
        }
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: indetifer1, for: indexPath)as!PulickWebCell            
            if viewModel.ListData.Introduce != "" {
                cell.loadHtmlString(html: viewModel.ListData.Introduce, isFirst: isfirst1)
                isfirst1 = true
                cell.FuncCallbackValue(value: {[weak self] (height) in
                    self?.hotelIntroduceHeight = height
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
                    self?.BookingHeight = height
                    self?.tableView.reloadData()
                })
            }
            return cell
        }
        else if (indexPath.section == 3){
            
            let cell = UserCommentCell.init(style: .subtitle, reuseIdentifier: identifier)
            cell.InitConfig(cViewModel.ListData[indexPath.row] as Any)
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            if viewModel.ListData.HotelProduct!.count != 0 {
                
                let vc = CommonFunction.ViewControllerWithStoryboardName("HotelFacilities", Identifier: "HotelFacilities") as! HotelFacilities
                vc.HotelProduct = viewModel.ListData.HotelProduct?[indexPath.row]
                vc.DateTimeBegin = DateTimeBegin
                vc.DateTimeEnd   = DateTimeEnd
                vc.startMoon = startMoon
                vc.startDay  = startDay
                vc.endDay    = endDay
                vc.endMoon   = endMoon
                vc.totalNumber = totalNumber
                self.navigationController?.show(vc, sender: self  )
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 || indexPath.section == 2 {
            if cell.responds(to:#selector(setter: UIView.layoutMargins)) {
                cell.layoutMargins = UIEdgeInsets.zero
            }
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = UIEdgeInsets.zero
            }
        }
        
        
    }
}
