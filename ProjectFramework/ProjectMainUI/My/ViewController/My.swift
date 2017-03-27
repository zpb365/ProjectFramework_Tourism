//
//  My.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import SwiftTheme

class My: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let identifier="MyCell"
    
    let ImageList = ["订单","订单","订单","订单","订单","订单","订单","订单","订单"]
    let TitleList = ["我的订单","我的收藏","我的足迹","订单查询","游记管理","个人信息","我的点评","清除缓存","我要反馈"]
    
    
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
 
    ///UITableView
    lazy var tableView:UITableView = {
        var _frame=self.view.frame
        _frame.origin.y -= 20
        _frame.size.height += 20
        let tabview=UITableView(frame: _frame, style: .plain)
        tabview.delegate=self //设置代理
        tabview.dataSource=self
        tabview.tableFooterView=UIView() //去除多余底部线条
        return tabview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 239 191 133
        
        self.view.backgroundColor = CommonFunction.RGBA(239, g: 191, b: 133, a: 1)
        self.tableView.backgroundColor = UIColor.clear
        tableView.register(MyCell.self, forCellReuseIdentifier: identifier)
        self.view.addSubview(tableView)
        _ = MyHeadUIView()._layer(tableHeaderView: tableView, target: self, selector: #selector(UserInfoEdit))
        
        SetupNavBar()
    }
    
    
    ///自定义UINavigationBar
    private func SetupNavBar(){
        
        let CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        self.view.addSubview(CustomNavBar)
        
        CustomNavBar.shadowImage=UIImage()
        CustomNavBar.isTranslucent=true
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor.clear, size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
 
        let CustomNavItem = UINavigationItem()
        
        CustomNavBar.pushItem(CustomNavItem, animated: true)
        
        CustomNavItem.leftBarButtonItem=UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        
        let rightitem = UIBarButtonItem(customView: UIBarButtonItem().NavItemWithImageName(imageName: "message", highImageName: "message", target: self, action: #selector(self.righButtonItem)))
        rightitem.customView?.addSubview(BadgenumberLabel)
        rightitem.customView?.bringSubview(toFront: BadgenumberLabel)
        
        CustomNavItem.rightBarButtonItem=rightitem  //消息
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommonFunction.kScreenHeight-160
    }
    
    //返回节的个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //返回某个节中的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //为表视图单元格提供数据，该方法是必须实现的方法
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyCell
        cell.accessoryType = UITableViewCellAccessoryType.none
        cell.selectionStyle = .none
        cell._InitConfig(ImageList,TitleList)
        return cell
    }
    
    
    ///消息
    func righButtonItem (){
        let controller9 = CommonFunction.ViewControllerWithStoryboardName("Shopping", Identifier: "Shopping") as! Shopping
        
        self.navigationController?.show(controller9, sender: self)
        
    }
    
    ///用户信息
    func UserInfoEdit (){
        
        if(Global_UserInfo.IsLogin==false){ //未登录
           // LoginLogicViewModel().LoginLogicViewModel(self)
        }else{  //已登录
            let vc = CommonFunction.ViewControllerWithStoryboardName("Myinfo", Identifier: "Myinfo") as! MyInfoViewController
            self.navigationController?.show(vc, sender: nil)
        }
        
    }
 

}
