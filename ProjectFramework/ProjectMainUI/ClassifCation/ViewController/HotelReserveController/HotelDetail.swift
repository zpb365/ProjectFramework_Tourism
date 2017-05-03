//
//  HotelDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/21.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HotelDetail: CustomTemplateViewController {
    
    
    lazy var sectionDate:UIView = {
        let sectionDate = Bundle.main.loadNibNamed("DateSectionView", owner: self, options: nil)?.last
        return sectionDate as! UIView
        
    }()
    lazy var sectionConment:UIView = {
        let sectionConment = Bundle.main.loadNibNamed("CommentSectionView", owner: self, options: nil)?.last
        
        return sectionConment as! UIView
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!//头部视图
    @IBOutlet weak var ReserveCount: UILabel!//今天酒店的预定数
    @IBOutlet weak var buttonBar: UIView!
    @IBOutlet weak var headimage: UIImageView!//头部图片
    @IBOutlet weak var address: UIView!//头部地址
    @IBOutlet weak var phone: UIImageView!//头部电话
    @IBOutlet weak var VRVedio: UIView!//头部VR视频
    
    let identiFier = "HotelRoomReserveCell"
    let identifier = "UserCommentCell"
    let indetifer1 = "cell1"
    let indetifer2 = "cell2"
    
    
    var CustomNavBar:UINavigationBar!=nil
    var backBtn:UIButton!=nil
    var cellectionBtn:UIButton!=nil
    var shareBtn:UIButton!=nil
    var alph: CGFloat = 0
    var modelArray = Array<Any>()
    var hotelIntroduceHeight: CGFloat = 50//酒店介绍的高度
    var BookingHeight: CGFloat = 50//预定须知的高度
    var isChange: Bool = false//防止tableView重复滑动的标记
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#5E7D8A"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        self.setHeadView()
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
    }
    //MARK: 请求数据
    
    //MARK: initUI
    func initUI() -> Void {
        let model = UserCommentModel()
        model.comment = "呵呵呵呵呵呵呵呵呵呵额呵呵撒会受到hi欧委会IQ哦好滴哦我去hi噢hi噢hi噢hi哦我回去低耦合我我哦青海地区哦和我我odhqioifuheui手动切换为我哦亲hi殴打hi哦我去hi哦"
        model.imageArray = []
        model.nickName = "住朋购友"
        modelArray.append(model)
        
        
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y:0, w: self.view.frame.width, h: self.view.frame.height)
        self.tableView.tableHeaderView = tableViewHead
        self.header.isHidden = true
        self.tableView.register(UserCommentCell.self, forCellReuseIdentifier: identifier)
        self.tableView.register(PulickWebCell.self, forCellReuseIdentifier: indetifer1)
        self.tableView.register(PulickWebCell.self, forCellReuseIdentifier: indetifer2)
        
    }
    func tapClick(tap:UITapGestureRecognizer) -> Void {
        switch tap.view!.tag {
        case 1000:
            let urllist=["http://pic9.nipic.com/20100902/2029588_234330095230_2.jpg"
                ,"http://pic1a.nipic.com/2008-08-26/200882614319401_2.jpg"
                ,"http://www.ahhnh.com/data/upload/2015-10/2015101940975833.jpg"
                ,"http://pic10.nipic.com/20100929/4879567_114926982000_2.jpg"
                ,"http://img2.imgtn.bdimg.com/it/u=2081796248,4191591232&fm=21&gp=0.jpg"]
            let describeList=["张三","李四","李四","李四","李四"]
            let vc = ImagePreviewViewController( ImageUrlList: urllist ,IsDescribe: true,DescribeList: describeList )
            self.navigationController?.pushViewController(vc, animated: true )
        case 1001:
            print("跳转到百度地图")
        case 1002:
            CommonFunction.CallPhone(self, number: "15907740425")
        case 1003:
            print("跳转到全景动画")
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
        CustomNavItem.rightBarButtonItems=[UIBarButtonItem.init(customView: shareBtn),UIBarButtonItem.init(customView: cellectionBtn)]
        
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
        //  1 预定酒店   2 酒店简介  3 用户点评
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: button.tag - 1), at: .middle, animated: true)
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
            if (offset < 10 * 80 + tableViewHead.frame.height) {
                self.btoomLineMove(tag: 1)
            }
            if (offset > 10 * 80 + tableViewHead.frame.height && offset < 10 * 80 + tableViewHead.frame.height + hotelIntroduceHeight + 40) {
                self.btoomLineMove(tag: 2)
            }
            if (offset > 10 * 80 + tableViewHead.frame.height + hotelIntroduceHeight + 40 && offset < 10 * 80 + tableViewHead.frame.height + hotelIntroduceHeight + BookingHeight + 80) {
                self.btoomLineMove(tag: 3)
            }
            if (offset > 10 * 80 + tableViewHead.frame.height + hotelIntroduceHeight + BookingHeight + 80){
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
        _viewForHeaderInSection[1] = UIView().setIntroduceView(height: 40, title: "酒店介绍")
        _viewForHeaderInSection[2] = UIView().setIntroduceView(height: 40, title: "预定须知")
        _viewForHeaderInSection[3] = sectionConment
        return _viewForHeaderInSection[section]
    }
    var _heightForHeaderInSection = [40,40,40,50]
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(_heightForHeaderInSection[section])
    }
  
    var _numberOfRowsInSection = [10,1,1,5]
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _numberOfRowsInSection[section]
    }
    var _heightForRowAt = [CGFloat(80),CGFloat(0),CGFloat(0),CGFloat(0)]
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let model = self.modelArray[0] as! UserCommentModel //暂时为了显示数据  有接口就移除
        _heightForRowAt[1] = hotelIntroduceHeight > CGFloat(50) ? hotelIntroduceHeight : CGFloat(50)
        _heightForRowAt[2] = BookingHeight > CGFloat(50) ? BookingHeight : CGFloat(50)
        _heightForRowAt[3] = self.tableView.getHeightWithCell(lableWidth: CommonFunction.kScreenWidth - 35, commont: model.comment, imageArray: model.imageArray, showCount: model.imageArray.count, rowCount: 4, contenViewWidth: CommonFunction.kScreenWidth - 35, xMargin: 10, yMargin: 10) + 48 + 10
        return _heightForRowAt[indexPath.section]
    }
    //数据源
    var isfirst1: Bool = false
    var isfirst2: Bool = false
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! HotelRoomReserveCell
            return cell
        }
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: indetifer1, for: indexPath)as!PulickWebCell
            cell.FuncCallbackValue(value: {[weak self] (height) in
                self?.hotelIntroduceHeight = height
            })
            cell.loadHtmlString(html: "<p>“99旅馆连锁”北京丰益桥店地处北京市西三环主路边上，是西三环线的交通枢纽、商务中心，近地铁10号线泥洼站。门店西临北京四大汽车交易市场之一的西三环汽配城、美克美家家居装饰城、东方家园以及中国军区总院的309医院。酒店靠近丽泽长途汽车站、六里桥长途汽车站，周边还有大糖梨烤鸭店、老诚一锅、老...</p>", isFirst: isfirst1)
            isfirst1 = true
            return cell
        }
        
        if (indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: indetifer2, for: indexPath)as!PulickWebCell
            cell.FuncCallbackValue(value: {[weak self] (height) in
                self?.BookingHeight = height
                self?.tableView.reloadData()
            })
            cell.loadHtmlString(html: "<p>品牌：xiaomi/小米</p><p>    型号：小米Max<br/></p><p>    款式：直板<br/></p><p>    颜色：金色 银色<br/></p><p>    后置摄像头：<span style=\"color: rgb(192, 0, 0);\">1600</span>万<br/></p><p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          附加功能：OTG WIFIH上网 双卡双待 高清视频<br/></p><p>    宝贝成色：全新<br/></p>", isFirst: isfirst2)
            isfirst2 = true
            return cell
        }
        else if (indexPath.section == 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)as!UserCommentCell
            cell.InitConfig(self.modelArray[0])
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = CommonFunction.ViewControllerWithStoryboardName("HotelFacilities", Identifier: "HotelFacilities") as! HotelFacilities
            self.navigationController?.show(vc, sender: self  )
        }
    }
    
}
