//
//  ScenicSpotMain.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/13.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotMain: CustomTemplateViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var buttonBar: UIView!
    
    ///按钮折叠）属性
    lazy var rightImage:UIButton = {
        
        let rightImage = UIButton.init(frame: CommonFunction.CGRect_fram(CommonFunction.kScreenWidth - 5 - 20, y: 25, w: 16, h: 16))
        rightImage.isSelected=true
        //
        rightImage.setImage(UIImage.init(named: "arrowdown"), for: .normal)
        rightImage.setImage(UIImage.init(named: "arrowup"), for: .selected)
        rightImage.addTarget(self, action: #selector(footerTap), for: .touchUpInside)
        return rightImage
    }()
    ///组尾
    lazy var sectionFooter:UIView = {
        let sectionFooter = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
        sectionFooter.backgroundColor = UIColor.white
        
        let button = UIButton.init(type: .custom)
        button.frame = CommonFunction.CGRect_fram(5, y: 10, w: 60, h: 40)
        button.setTitle("购票", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setImage(UIImage(named: "tikect"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.isUserInteractionEnabled = false
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(footerTap))
        sectionFooter.addGestureRecognizer(tap)
        sectionFooter.addSubview(button)
        
        return  sectionFooter
    }()

    let identiFier  = "TicketCell"
    var CustomNavBar:UINavigationBar!=nil
    var backBtn:UIButton!=nil
    var cellectionBtn:UIButton!=nil
    var shareBtn:UIButton!=nil
    var alph: CGFloat = 0
    var head: UIView! = nil
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavBar()
        self.setHeadView()
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    //MARK: 设置头部
    func setHeadView() -> Void {
        let titleArray: Array=["购票","景点介绍","用户点评"]
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
    //MARK: 设置导航栏
    func setNavBar() -> Void {
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除 
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor().withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
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
        cellectionBtn.tag = 101
        cellectionBtn.backgroundColor = UIColor.gray
        cellectionBtn.layer.cornerRadius = 15
        cellectionBtn.setImage(UIImage(named: "scanning"), for: .normal)
        cellectionBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        //分享
        shareBtn = UIButton(type: .custom)
        shareBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        shareBtn.tag = 102
        shareBtn.backgroundColor = UIColor.gray
        shareBtn.layer.cornerRadius = 15
        shareBtn.setImage(UIImage(named: "scanning"), for: .normal)
        shareBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        
        CustomNavItem.leftBarButtonItem=UIBarButtonItem.init(customView: backBtn)
        CustomNavItem.rightBarButtonItems=[UIBarButtonItem.init(customView: shareBtn),UIBarButtonItem.init(customView: cellectionBtn)
]

        
        CustomNavBar.pushItem(CustomNavItem, animated: true)
    }
    //返回按钮方法
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
    
    //MARK: initUI
    
    func initUI(){
        //组尾添加按钮
        sectionFooter.addSubview(rightImage)
        
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y:0, w: self.view.frame.width, h: self.view.frame.height)
        self.tableView.tableHeaderView = tableViewHead
        self.header.isHidden = true
        
        
    }
    //MARK: tableViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
            buttonBar.frame=CGRect(x: 0, y: 330, width: CommonFunction.kScreenWidth, height: 40)
            tableViewHead.addSubview(buttonBar)
            
        }
    }
    //组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 0
        }
        else if(section == 1){
            return rightImage.isSelected ? 10 : 0
        }
        else if(section == 2){
            return 1
        }
        else{
            return 5
        }
    }
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 0
        }
        else if (indexPath.section == 1){
            return 100
        }
        else if (indexPath.section == 2){
            return 300
        }
        else{
            return 50
        }
    }

    //组尾
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section == 0) {

            return sectionFooter
        }
        else{
            return nil
        }
    }

    //组尾高
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        if ( section == 0) {
            return 50
        }
        else{
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! TicketCell
            return cell
        }
        if (indexPath.section == 2) {
            return UITableViewCell()
        }
        else{
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.text = "用户评论" 
            return cell
        }
    }
    //MARK: 组头按钮方法
    func headerClick(_ button: UIButton) {
        //底部线滑动
        UIView.animate(withDuration: 0.3) {
            let line = self.buttonBar.viewWithTag(666)
            line?.center.x = button.center.x
        }
        //0头  1 购票   2 景区介绍  3 评论

        if (button.tag == 1 && rightImage.isSelected == false){
            return
        }
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: button.tag), at: .middle, animated: true)
 
        
    }
    //MARK: 折叠效果
    func footerTap() -> Void {
        //反选刷新数据
        rightImage.isSelected = !rightImage.isSelected
       self.tableView.reloadSections(NSIndexSet.init(index: 1) as IndexSet, with: .automatic)
        
    }
}
