//
//  My.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import SwiftTheme
import SDWebImage

class My: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let identifier="MyCell"
    
    var ImageList = ["我的订单","游记","个人信息","反馈","联系客服","清除缓存","关于我们","安全退出"]
    var TitleList = ["我的订单","游记管理","个人信息","我要反馈","联系客服","清除缓存","关于我们","安全退出"]
    
    let _MyHeadUIView=MyHeadUIView()
    
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
        _ = _MyHeadUIView._layer(tableHeaderView: tableView, target: self, selector: #selector(UserInfoEdit))
        SetupNavBar()
        if(Global_UserInfo.IsLogin==true){
            self._MyHeadUIView.Imgbtn?.ImageLoad(PostUrl: HttpsUrlImage+Global_UserInfo.HeadImgPath)
            self._MyHeadUIView.LabName.text=Global_UserInfo.RealName
            if Global_UserInfo.authorizationtype == 1{
                ImageList.insert("挖掘", at: self.TitleList.count-1)
                TitleList.insert("数据挖掘", at: self.TitleList.count-1)
                
                self.tableView.reloadData()
            }
        }else{
            self.TitleList.remove(at: self.TitleList.count-1)
            self.ImageList.remove(at: self.ImageList.count-1)
            self.tableView.reloadData()
        }
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
        if(Global_UserInfo.IsLogin==true){
            self._MyHeadUIView.Imgbtn?.ImageLoad(PostUrl: HttpsUrlImage+Global_UserInfo.HeadImgPath)
        }else{
            self._MyHeadUIView.Imgbtn?.image = UIImage.init(named: "userIcon_defualt")
        }
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
        //按钮点击跳转
        cell.FuncCallbackValue {[weak self] (button) in
            
            switch button.tag {
            case 100:
                if(Global_UserInfo.IsLogin==false){
                 self?.loginFunc()
                    return
                }
                let vc = CommonFunction.ViewControllerWithStoryboardName("MyOder", Identifier: "MyOder") as! MyOder
                self?.navigationController?.show(vc, sender: self  )
                break;
            case 101:
                if(Global_UserInfo.IsLogin==false){
                    self?.loginFunc()
                    return
                }
                let vc = CommonFunction.ViewControllerWithStoryboardName("TravelManagement", Identifier: "TravelManagement") as! TravelManagement
                self?.navigationController?.show(vc, sender: self  )
                break;
            case 102:
                if(Global_UserInfo.IsLogin==false){
                    self?.loginFunc()
                    return
                }
                let vc = CommonFunction.ViewControllerWithStoryboardName("Myinfo", Identifier: "Myinfo") as! MyInfoViewController
                self?.navigationController?.show(vc, sender: nil)
                break;
            case 103:
                
                let vc = CommonFunction.ViewControllerWithStoryboardName("Feedback", Identifier: "Feedback") as! FeedbackViewController
                self?.navigationController?.show(vc, sender: nil)
                break;
            case 104:
           CommonFunction.CallPhone(self!, number: "0771-96355")
                break;
            case 105:
                print("缓存")
                //显示缓存大小
                let intg: Int = Int(SDImageCache.shared().getSize())
                let currentVolum: String = "\(self!.fileSizeWithInterge(intg))"
                
                SDImageCache.shared().clearDisk(onCompletion: {
                    //清除缓存
                    SDImageCache.shared().clearMemory()
                    CommonFunction.MessageNotification("为您清除了"+currentVolum, interval: 2, msgtype: .success,font: UIFont.systemFont(ofSize: 13))
                })
                break;
            case 106:
                let vc = CommonFunction.ViewControllerWithStoryboardName("About", Identifier: "About") as! AboutViewController
                self?.show(vc, sender: self)
                break
            case 107:
                if (self?.ImageList.count)! == 9{
                    let vc = Public360ViewController()
                    vc.url = "http://wj.8gsky.com"
                    self?.present(vc, animated: true, completion:nil)
                }else{
                    self?.Cancellation()
                }
                break;
            case 108:
                self?.Cancellation()
                break;
            default:
                
                break
            }
        }
        return cell
    }
    
    
    ///消息
    func righButtonItem (){
        let vc = CommonFunction.ViewControllerWithStoryboardName("Message", Identifier: "Message") as! MessageViewController
        self.navigationController?.show(vc, sender: self)
        
    }
    
    ///用户信息
    func UserInfoEdit (){
        
        if(Global_UserInfo.IsLogin==false){ //未登录 
          loginFunc()
        }else{  //已登录
            let vc = CommonFunction.ViewControllerWithStoryboardName("Myinfo", Identifier: "Myinfo") as! MyInfoViewController
            self.navigationController?.show(vc, sender: nil)
        }
    
    }
    //登录
    func loginFunc(){
        let vc = LoginViewControllerTwo()
        vc.Callback_Value({[weak self] (isOk) in
            //登录成功
            
            self?._MyHeadUIView.Imgbtn.ImageLoad(PostUrl: HttpsUrlImage+Global_UserInfo.HeadImgPath)
            self?._MyHeadUIView.LabName.text=Global_UserInfo.RealName
            self?.ImageList.append("安全退出")
            self?.TitleList.append("安全退出")
            
            if Global_UserInfo.authorizationtype == 1{
                self?.ImageList.insert("挖掘", at: (self?.TitleList.count)!-1)
                self?.TitleList.insert("数据挖掘", at: (self?.TitleList.count)!-1)
                self?.tableView.reloadData()
            }
            self?.tableView.reloadData()
        })
        self.present(vc, animated: true, completion: nil)
    }
    
    //注销账户
    func Cancellation(){
        CommonFunction.AlertController(self, title: "注销", message: "确定注销该账户吗？", ok_name: "确定", cancel_name: "取消", style: .alert, OK_Callback: {
            
            CommonFunction.ExecuteUpdate("update MemberInfo set userid = (?), PhoneNo = (?) , Token = (?), IsLogin = (?) ,RealName=(?),Sex=(?),HeadImgPath=(?)",
                                         ["" as AnyObject
                                            ,"" as AnyObject
                                            ,"" as AnyObject
                                            ,false as AnyObject
                                            ,"" as AnyObject
                                            ,"" as AnyObject
                                            ,"" as AnyObject
                ], callback: nil)
            
            Global_UserInfo=MyInfoModel()
            
            self._MyHeadUIView.Imgbtn.image=UIImage.init(named: "userIcon_defualt")
            self._MyHeadUIView.LabName.text="Hi,给我取个名字吧"
            self.TitleList.remove(at: self.TitleList.count-1)
            self.ImageList.remove(at: self.ImageList.count-1)
            self.TitleList.remove(at: self.TitleList.count-1)
            self.ImageList.remove(at: self.ImageList.count-1)
            //移除极光推送别名
            JPUSHService.setAlias(Global_UserInfo.userid.description, callbackSelector: nil, object: self )
            self.tableView.reloadData()
        }, Cancel_Callback: {
            
        })
    }
 
    
    
    
    //获取缓存大小
    func fileSizeWithInterge(_ size: Int) -> String {
        // 1k = 1024, 1m = 1024k
        if size < 1024 {
            // 小于1k                                         
            return "\(Int(size))B"
        }
        else if size < 1024 * 1024 {
            // 小于1m
            let aFloat: CGFloat = CGFloat(size) / 1024
            return String(format: "%.0fK", aFloat)
        }
        else if size < 1024 * 1024 * 1024 {
            // 小于1G
            let aFloat: CGFloat = CGFloat(size) / (1024 * 1024)
            return String(format: "%.1fM", aFloat)
        }
        else {
            let aFloat: CGFloat = CGFloat(size) / (1024 * 1024 * 1024)
            return String(format: "%.1fG", aFloat)
        }
        
    }

}
