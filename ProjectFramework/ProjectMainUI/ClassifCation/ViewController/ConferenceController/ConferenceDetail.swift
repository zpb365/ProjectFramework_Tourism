//
//  ConferenceDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/28.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ConferenceDetail: CustomTemplateViewController {
    
    lazy var sectionConment:UIView = {
        let sectionConment = Bundle.main.loadNibNamed("CommentSectionView", owner: self, options: nil)?.last
        
        return sectionConment as! UIView
    }()
    lazy var sectionTime:UIView = {
        let sectionTime = Bundle.main.loadNibNamed("TimeQuantum", owner: self, options: nil)?.last
        
        return sectionTime as! UIView
    }()
    
    lazy var sectionIntroduce: PulickIntroduceView = {
        let sectionIntroduce = PulickIntroduceView()
        sectionIntroduce.createTableView(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
        sectionIntroduce.FuncCallbackValue(value: { [weak self](height) in
            self?.height = height
            self?.sectionIntroduce.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height)
            self?.sectionIntroduce.customTableView.frame = (self?.sectionIntroduce.bounds)!
            self?.tableView.reloadData()
            //            print("介绍的tableview高度====",height)
        })
        return sectionIntroduce
    }()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var buttonBar: UIView!

    
    let identiFier = "ConferenceReserveCell"
    let identifier = "UserCommentCell"
    
    var CustomNavBar:UINavigationBar!=nil
    var backBtn:UIButton!=nil
    
    var cellectionBtn:UIButton!=nil
    var shareBtn:UIButton!=nil
    var alph: CGFloat = 0
    var modelArray = Array<Any>()
    var height: CGFloat = 50
    var isChange: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        self.initUI()
        self.setHeadView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: tableViewDelegate
    //MARK: 开始拖动时调用的方法
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isChange = true
//        self.sectionIntroduce.setData(object: self, textArray: ["会展政策","参会须知"])//后期网络接口传值
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
    }
    //组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    var _viewForHeaderInSection = [UIView(),UIView(),UIView()]
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        _viewForHeaderInSection[0] = sectionTime
        _viewForHeaderInSection[1] = sectionIntroduce
        _viewForHeaderInSection[2] = sectionConment
        return _viewForHeaderInSection[section]
    }
    var _heightForHeaderInSection = [35,50,50]
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        _heightForHeaderInSection[1] = Int(height) > 50 ? Int(height) : 50
        return CGFloat(_heightForHeaderInSection[section])
    }
    var _numberOfRowsInSection = [10,0,5]
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _numberOfRowsInSection[section]
    }
    var _heightForRowAt = [CGFloat(80),CGFloat(0),CGFloat(0)]
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
//        let model = self.modelArray[0] as! UserCommentModel //暂时为了显示数据  有接口就移除
//        _heightForRowAt[2] = self.tableView.getHeightWithCell(lableWidth: CommonFunction.kScreenWidth - 35, commont: model.comment, imageArray: model.imageArray, showCount: model.imageArray.count, rowCount: 4, contenViewWidth: CommonFunction.kScreenWidth - 35, xMargin: 10, yMargin: 10) + 48 + 10
        return _heightForRowAt[indexPath.section]
    }
    //数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ConferenceReserveCell
            return cell
        }
        if (indexPath.section == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)as!UserCommentCell
            cell.InitConfig(self.modelArray[0])
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    //MARK: 悬浮按钮方法
    func headerClick(_ button: UIButton) {
        isChange = false
        //底部线滑动
        UIView.animate(withDuration: 0.3) {
            let line = self.buttonBar.viewWithTag(666)
            line?.center.x = button.center.x
        }
    }
    //MARK: 设置头部
    func setHeadView() -> Void {
        let titleArray: Array=["预定会展","会展简介","用户点评"]
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

    //MARK: initUI
    func initUI() -> Void {
//        let model = UserCommentModel()
//        model.comment = "呵呵呵呵呵呵呵呵呵呵额呵呵撒会受到hi欧委会IQ哦好滴哦我去hi噢hi噢hi噢hi哦我回去低耦合我我哦青海地区哦和我我odhqioifuheui手动切换为我哦亲hi殴打hi哦我去hi哦"
//        model.imageArray = ["icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg"]
//        model.nickName = "住朋购友"
//        modelArray.append(model)
        
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y:0, w: self.view.frame.width, h: self.view.frame.height)
        self.tableView.tableHeaderView = tableViewHead
        self.header.isHidden = true
        self.tableView.register(UserCommentCell.self, forCellReuseIdentifier: identifier)
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
        default:
            break
        }
        
    }

}
