//
//  ScenicSpot.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import SwiftTheme

class ScenicSpot: CustomTemplateViewController,PYSearchViewControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!//景点、景区数据
    
    let identiFier  = "ScenicSpot"
    let identiFier2 = "HotScenicSpot"
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setNavbar()
        self.initUI()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00ABEE"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00ABEE"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    
    // MARK: 设置导航栏
    func setNavbar(){

        let CustomNavItem = self.navigationItem
       
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索景点")
        CustomNavItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "address"), style: .done, target: self, action: #selector(GetAdress))
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        print("搜索")
        let searchViewController =   PYSearchViewController(hotSearches: nil, searchBarPlaceholder: "请输入您要查询的景点、景区")
        searchViewController?.hotSearchStyle = .default
        searchViewController?.searchHistoryStyle = .normalTag
        searchViewController?.delegate=self
        let nav =  CYLBaseNavigationController (rootViewController: searchViewController!)
        self.present(nav, animated: false, completion: nil)

    }
    func GetAdress() {
        print("当前地址")
    }
    
    
    
    // MARK: initUI
    func initUI(){
        //基控制器
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: 64, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 64)
        //tableView
        self.tableView.tableHeaderView = UIView().headView(width: CommonFunction.kScreenWidth, height: 35, leftViewColor: UIColor().TransferStringToColor("#26C6DA"), title: "景区", titleColor: UIColor.black)
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor().TransferStringToColor("D6D6D6")
        self.numberOfRowsInSection=8//显示的个数
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=100//行高

    }
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotCell
    return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableview ===",indexPath.row)
        let vc = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotMain", Identifier: "ScenicSpotMain") as! ScenicSpotMain
        self.navigationController?.show(vc, sender: self  )

        
    }
    
}
