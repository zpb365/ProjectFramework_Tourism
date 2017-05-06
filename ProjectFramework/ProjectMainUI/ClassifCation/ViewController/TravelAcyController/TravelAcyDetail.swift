//
//  TravelAcyDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/27.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcyDetail: CustomTemplateViewController {
    
    
    lazy var buyButton: UIButton = {
        let buyButton = UIButton.init(type: .system)
        buyButton.frame = CommonFunction.CGRect_fram(0, y: self.view.frame.height - 35, w: self.view.frame.width, h: 35)
        buyButton.backgroundColor = CommonFunction.SystemColor()
        buyButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        buyButton.setTitle("立即购买", for: .normal)
        buyButton.setTitleColor(UIColor.white, for: .normal)
        buyButton.tag = 103
        buyButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return buyButton
    }()
    lazy var sectionJourney: PulickWebView = {
        let sectionJourney = PulickWebView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 10))
        sectionJourney.FuncCallbackValue {[weak self] (height) in
            self?.sectionJourney.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height)
            self?.journeyHeight = height
//            self?.tableView.reloadData()
            print("+++++++",height)
        }
        return sectionJourney
    }()
    lazy var sectionIntroduce: PulickWebView = {
        let sectionIntroduce = PulickWebView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 10))
        sectionIntroduce.FuncCallbackValue {[weak self] (height) in
        self?.sectionIntroduce.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height)
        self?.introduceHeight = height
        self?.tableView.reloadData()
            print("-------",height)
        }
        return sectionIntroduce
    }()
    //费用说明
    lazy var sectionPrice: PulickIntroduceView = {
        let sectionPrice = PulickIntroduceView()
        sectionPrice.createTableView(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
        sectionPrice.FuncCallbackValue(value: { [weak self](height) in
            self?.priceHeight = height
            self?.sectionPrice.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height)
            self?.sectionPrice.customTableView.frame = (self?.sectionPrice.bounds)!
            self?.tableView.reloadData()
            //            print("介绍的tableview高度====",height)
        })
        return sectionPrice
    }()
    //预定须知
    lazy var sectionReserve: PulickIntroduceView = {
        let sectionReserve = PulickIntroduceView()
        sectionReserve.createTableView(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
        sectionReserve.FuncCallbackValue(value: { [weak self](height) in
            self?.reserveHeight = height
            self?.sectionReserve.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height)
            self?.sectionReserve.customTableView.frame = (self?.sectionReserve.bounds)!
            self?.tableView.reloadData()
            //            print("介绍的tableview高度====",height)
        })
        return sectionReserve
    }()
    //用户评论
    lazy var sectionConment:UIView = {
        let sectionConment = Bundle.main.loadNibNamed("CommentSectionView", owner: self, options: nil)?.last
        return sectionConment as! UIView
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var dateBase: UIView!
    @IBOutlet weak var buttonBar: UIView!
    
    
    let identfier0 = "PulickWebCell0"
    let identfier1 = "PulickWebCell1"
    let identifier = "UserCommentCell"
    
    var CustomNavBar:UINavigationBar!=nil
    var backBtn:UIButton!=nil
    var cellectionBtn:UIButton!=nil
    var shareBtn:UIButton!=nil
    var alph: CGFloat = 0
    var modelArray = Array<Any>()
    var journeyHeight: CGFloat = 10//行程富文本
    var introduceHeight:CGFloat = 10//简介富文本
    var priceHeight: CGFloat = 50 //费用说明
    var reserveHeight : CGFloat = 50   //预定须知
    var isChange: Bool = false
    
    //MARK: viewController
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        self.initUI()
        self.getData()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            if (offset < tableViewHead.frame.height + journeyHeight) {
                self.btoomLineMove(tag: 1)
            }
            if (offset > tableViewHead.frame.height + journeyHeight && offset < tableViewHead.frame.height + journeyHeight + introduceHeight) {
                self.btoomLineMove(tag: 2)
            }
            if (offset > tableViewHead.frame.height + journeyHeight + introduceHeight && offset < tableViewHead.frame.height + journeyHeight + introduceHeight + priceHeight) {
                self.btoomLineMove(tag: 3)
            }
            if (offset > tableViewHead.frame.height + journeyHeight + introduceHeight + priceHeight && offset < tableViewHead.frame.height + journeyHeight + introduceHeight + priceHeight + reserveHeight) {
                self.btoomLineMove(tag: 4)
            }
            if (offset > tableViewHead.frame.height + journeyHeight + introduceHeight + priceHeight + reserveHeight) {
                self.btoomLineMove(tag: 5)
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
        return 5
    }
    var _numberOfRowsInSection = [0,0,0,0,10]
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _numberOfRowsInSection[section]
    }
    //组头
    var _viewForHeaderInSection = [UIView(),UIView(),UIView(),UIView(),UIView()]
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        _viewForHeaderInSection[0] = sectionJourney
        _viewForHeaderInSection[1] = sectionIntroduce
        _viewForHeaderInSection[2] = sectionPrice
        _viewForHeaderInSection[3] = sectionReserve
        _viewForHeaderInSection[4] = sectionConment
        
        return _viewForHeaderInSection[section]
    }
    // 0行程 1简介 2费用说明 3预定须知 4评论
    var _heightForHeaderInSection = [0,0,0,0,50]
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        _heightForHeaderInSection[0] = Int(journeyHeight) > 0 ? Int(journeyHeight) : 10
        _heightForHeaderInSection[1] = Int(introduceHeight) > 0 ? Int(introduceHeight) : 10
        _heightForHeaderInSection[2] = Int(priceHeight) > 0 ? Int(priceHeight) : 0
        _heightForHeaderInSection[3] = Int(reserveHeight) > 0 ? Int(reserveHeight) : 0
        return CGFloat(_heightForHeaderInSection[section])
    }
    var _heightForRowAt = [CGFloat(0),CGFloat(0),CGFloat(0),CGFloat(0),CGFloat(0)]
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if self.modelArray.count > 0 {
//            let model = self.modelArray[0] as! UserCommentModel //暂时为了显示数据  有接口就移除
//            _heightForRowAt[4] = self.tableView.getHeightWithCell(lableWidth: CommonFunction.kScreenWidth - 35, commont: model.comment, imageArray: model.imageArray, showCount: model.imageArray.count, rowCount: 4, contenViewWidth: CommonFunction.kScreenWidth - 35, xMargin: 10, yMargin: 10) + 48 + 10
        }
        return _heightForRowAt[indexPath.section]
    }
    //数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
     
        if (indexPath.section == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)as!UserCommentCell
            if self.modelArray.count > 0 {
                cell.InitConfig(self.modelArray[0])
            }
            return cell

        }
        else{
            return UITableViewCell()
        }
    }
    
    //MARK: initUI
    func initUI() -> Void {
        //价格
        let xMargin = CGFloat (self.view.frame.width - 240 - 50) / 2
        for i in 0..<6 {
            let view = DateView.init(frame: CommonFunction.CGRect_fram(25 + (80+xMargin) * CGFloat (i%3) , y: 8 + (45+8) * CGFloat(i/3), w: 80, h: 45))
            dateBase.addSubview(view)
        }
        //悬浮条
        let titleArray: Array=["行程","简介","费用说明","预定须知","用户点评"]
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
        self.tableView.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight - 35)
        self.tableView.tableHeaderView = self.tableViewHead
        self.view.addSubview(self.buyButton)
    }
    //悬浮条按钮方法
    func headerClick(_ button: UIButton) -> Void {
        isChange = false
        //底部线滑动
        UIView.animate(withDuration: 0.3) {
            let line = self.buttonBar.viewWithTag(666)
            line?.center.x = button.center.x
        }
        if (button.tag == 5) {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: button.tag - 1), at: .middle, animated: true)
        }
        else{
           let height = self.getHeight(tag: button.tag)
            self.tableView.setContentOffset(CGPoint.init(x: 0, y:height ), animated: true)
        }
    }
    func getHeight(tag:Int) -> CGFloat {
        let heightArray = [tableViewHead.frame.height - 104,tableViewHead.frame.height - 104 + journeyHeight, tableViewHead.frame.height - 104 + journeyHeight + introduceHeight,tableViewHead.frame.height - 104 + journeyHeight + introduceHeight + priceHeight,]
        return heightArray[tag - 1]
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
        cellectionBtn.setImage(UIImage(named: "scanning"), for: .normal)
        cellectionBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        //分享
        shareBtn = UIButton(type: .custom)
        shareBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        shareBtn.tag = 102
        shareBtn.adjustsImageWhenHighlighted = false
        shareBtn.backgroundColor = UIColor.gray
        shareBtn.layer.cornerRadius = 15
        shareBtn.setImage(UIImage(named: "scanning"), for: .normal)
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
            print("购买")
            break
        default:
            break
        }
        
    }
    //MARK: getData
    func getData() -> Void {
//        let model = UserCommentModel()
//        model.comment = "呵呵呵呵呵呵呵呵呵呵额呵呵撒会受到hi欧委会IQ哦好滴哦我去hi噢hi噢hi噢hi哦我回去低耦合我我哦青海地区哦和我我odhqioifuheui手动切换为我哦亲hi殴打hi哦我去hi哦"
//        model.imageArray = ["icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg"]
//        model.nickName = "住朋购友"
//        modelArray.append(model)
        
        self.tableView.reloadData()
        
//        self.sectionPrice.setData(object: self, textArray: ["费用包含","费用不包含"])//后期网络接口传值
//        self.sectionReserve.setData(object: self, textArray: ["出行须知","特殊限制"])
        
        sectionJourney.loadHtmlString(html: "<p>香蕉是淀粉质丰富的有益水果。味甘性寒，可清热润肠</p><p>香蕉</p><p>香蕉</p><p>，促进肠胃蠕动，但脾虚泄泻者却不宜。根据“热者寒之”的原理，最适合燥热人士享用。痔疮出血者、因燥热而致胎动不安者，都可生吃蕉肉。</p><p>民间验方更有用香蕉炖冰糖，医治久咳；用香蕉煮酒，作为食疗。近代医学建议，用香蕉可治高血压，因它含钾量丰富，可平衡钠的不良作用，并促进细胞及组织生长。用香蕉可治疗便秘，因它能促进肠胃蠕动。</p><p>早餐午餐和晚餐分别吃一根香蕉，能够为人体提供丰富的钾，从而使得大脑血凝块几率降低约21%。</p><p>德国研究人员表示，用香蕉可治抑郁和情绪不安，因它能促进大脑分泌内啡化学物质。它能缓和紧张的情绪，提高工作效率，降低疲劳。</p>")
        sectionIntroduce.loadHtmlString(html: "<p>品牌：xiaomi/小米</p><p>    型号：小米Max<br/></p><p>    款式：直板<br/></p><p>    颜色：金色 银色<br/></p><p>    后置摄像头：<span style=\"color: rgb(192, 0, 0);\">1600</span>万<br/></p><p>    附加功能：OTG WIFIH上网 双卡双待 高清视频<br/></p><p>    宝贝成色：全新<br/></p>")
    }

}
