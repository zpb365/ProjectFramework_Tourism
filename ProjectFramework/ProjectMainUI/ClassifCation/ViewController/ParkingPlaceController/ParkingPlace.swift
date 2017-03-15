//
//  ParkingPlace.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ParkingPlace: CustomTemplateViewController {

    let identiFier  = "ParkingPlaceCell"
    @IBOutlet weak var tableView: UITableView!
    let headView = UIView().headView(width: CommonFunction.kScreenWidth, height: 30, leftViewColor: UIColor().TransferStringToColor("#00C7D8"), title: "停车场", titleColor: UIColor.black)
    
//    func  Gettest (str:String,callback: ((_ isOK: Bool)->Void)?){
//        let test=str
//        callback?(true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
//        Gettest(str: "") { (<#Bool#>) in
//            <#code#>
//        }
        //基控制器
        self.InitCongif(tableView)

        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight)
        self.tableView.tableHeaderView = headView
        self.numberOfRowsInSection=8//显示的个数
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=70//行高
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00BDD1"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    // MARK: 设置导航栏
    func setNavbar(){
        
        let CustomNavItem = self.navigationItem
        
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索停车场")
        CustomNavItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "scanning"), style: .done, target: self, action: #selector(GetAdress))
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        print("搜索")
    }
    func GetAdress() {
        print("当前地址")
    }
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ParkingPlaceCell
        return cell
        
    }
    

}
