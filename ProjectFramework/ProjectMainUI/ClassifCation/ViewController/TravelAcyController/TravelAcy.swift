//
//  TravelAcy.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcy: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    let identFier = "TravelAcyCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        //基控制器
        self.InitCongif(tableView)
        self.numberOfRowsInSection=10//显示的个数
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=168//行高
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#FF5431"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    // MARK: 设置导航栏
    func setNavbar(){
        
        let CustomNavItem = self.navigationItem
        
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索旅行社")
        CustomNavItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "scanning"), style: .done, target: self, action: #selector(GetAdress))
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        print("搜索")
    }
    func GetAdress() {
        print("当前地址")
    }
    // MARK: override func tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identFier, for: indexPath) as! TravelAcyCell
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("TravelAcyDetail", Identifier: "TravelAcyDetail") as! TravelAcyDetail
        self.navigationController?.show(vc, sender: self  )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
