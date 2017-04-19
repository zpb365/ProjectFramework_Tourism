//
//  Restaurant.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class Restaurant: CustomTemplateViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var Menuview:MenuView?=nil
    let identFier = "RestaurantCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏
        self.setNavbar()
        self.setMeunView()
        //基控制器
        self.InitCongif(tableView)
        self.numberOfRowsInSection=10//显示的个数
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=142//行高
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight+30, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight-30)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00BDD1"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    //视图即将消失
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00BDD1"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identFier, for: indexPath) as! RestaurantCell
        cell.InitConfig("")
        return cell        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("RestaurantDetail", Identifier: "RestaurantDetail") as! RestaurantDetail
        self.navigationController?.show(vc, sender: self  )
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

    // MARK: 设置导航栏
    func setNavbar(){
        
        let CustomNavItem = self.navigationItem
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索餐厅")
        CustomNavItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "address"), style: .done, target: self, action: #selector(GetAdress))
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        print("搜索")
    }
    func GetAdress() {
        print("当前地址")
    }


}
