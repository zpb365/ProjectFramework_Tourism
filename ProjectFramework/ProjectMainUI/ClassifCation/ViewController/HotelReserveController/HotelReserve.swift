//
//  HotelReserve.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HotelReserve: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    var Menuview:MenuView?=nil
    let identFier = "HotelReserveCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏
        self.setNavbar()
        self.setMeunView()
        //基控制器
        self.InitCongif(tableView)
        self.numberOfRowsInSection=10//显示的个数
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=90//行高
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight+30, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight-30)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#5E7D8A"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identFier, for: indexPath) as! HotelReserveCell
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("HotelDetail", Identifier: "HotelDetail") as! HotelDetail
        self.navigationController?.show(vc, sender: self  )
    }
    // MARK: 设置导航栏
    func setNavbar(){
        
        let CustomNavItem = self.navigationItem
     
         CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索酒店")
        CustomNavItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "scanning"), style: .done, target: self, action: #selector(GetAdress))
    }
    // MARK:    菜单栏
    func setMeunView(){
        Menuview=MenuView(delegate: self, frame:  CGRect(x: 0, y: 64, width: self.view.frame.width, height: 30))
        self.view.addSubview(Menuview!)
        
        let mol3 = MenuModel()
        for   i:Int in 0  ..< 3 {
            let Onemol=OneMenuModel()
            Onemol.name="面积\(i)  "
            Onemol.value=i.description
            mol3.OneMenu.append(Onemol)
        }
        Menuview?.AddMenuData(mol3)
        
        //-----------------------刷新数据等操作在这个闭包执行-------------------------
        Menuview?.Callback_SelectedValue { (name, value) in
            print(name,value)
            
        }
        Menuview?.menureloadData()    //刷新菜单 (每次加载完数据后都需要刷新
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        print("搜索")
    }
    func GetAdress() {
        print("当前地址")
    }
   
    
}
