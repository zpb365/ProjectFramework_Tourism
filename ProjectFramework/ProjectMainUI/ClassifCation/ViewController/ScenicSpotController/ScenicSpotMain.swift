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
    
    
    let identiFier  = "TicketCell"
    var CustomNavBar:UINavigationBar!=nil
    var backBtn:UIButton!=nil
    var cellectionBtn:UIButton!=nil
    var shareBtn:UIButton!=nil
    var alph: CGFloat = 0
    let titleArray: Array=["购票","景点介绍","用户点评"]
    let bottomLine: UIView!=nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavBar()
        self.initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    //MAKE: 设置导航栏
    func setNavBar() -> Void {
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除
        CustomNavBar.shadowImage=UIImage()
        CustomNavBar.isTranslucent=true
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
        CustomNavItem.rightBarButtonItems=[UIBarButtonItem.init(customView: cellectionBtn),UIBarButtonItem.init(customView: shareBtn)
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
    
    //MAKE: initUI
    
    func initUI(){
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y: 0, w: self.view.frame.width, h: self.view.frame.height)
        self.tableView.tableHeaderView = tableViewHead
        self.header.isHidden = true
        
        
    }
    //MAKE: tableViewDelegate
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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 0
        }
        else if(section == 1){
            return 10
        }
        else if(section == 2){
            return 0
        }
        else{
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 0
        }
        else if (indexPath.section == 1){
            return 100
        }
        else{
            return 0
        }
    }
    //组头
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let view = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 40))
            view.backgroundColor = UIColor.white
            
            for i in 0..<titleArray.count {
                let title = titleArray[i]
                let button = UIButton.init(type: .system)
                let frame_x = CGFloat((CommonFunction.kScreenWidth/CGFloat(titleArray.count))*CGFloat(i))
                button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:CommonFunction.kScreenWidth / CGFloat(titleArray.count) , h: 35)
                button.tag = 200 + i
                button.setTitle(title, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                button.setTitleColor(UIColor.black, for: .normal)
                button.addTarget(self, action:#selector(headerClick), for: .touchUpInside)
                
                if (i == 0) {
                    bottomLine.frame = CommonFunction.CGRect_fram(0, y: 35, w: 80, h: 2)
                    bottomLine.center.x = button.center.x
                    bottomLine.backgroundColor = UIColor.blue
                }
            }
            
            
            return view
        }
        else{
            return nil
        }
    }
    //组尾
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section == 0) {
            
            let view = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 40))
            view.backgroundColor = UIColor.gray
            return view
        }
        else{
            return nil
        }
    }
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if (section == 0) {
            return 40
        }
        else{
            return 0
        }
    }
    //组尾高
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        if ( section == 0) {
            return 40
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
        else{
            return UITableViewCell()
        }
    }
    //MAKE: 组头按钮方法
    func headerClick(_ button: UIButton) {
        
    }
}
