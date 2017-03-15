//
//  ScenicSpot.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import SwiftTheme

class ScenicSpot: CustomTemplateViewController,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!//景点、景区数据
    @IBOutlet weak var tableViewHead: UIView!//tableview头部视图
    @IBOutlet weak var collectionView: UICollectionView!//头部视图滑动视图
    
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
    
    
    // MARK: 设置导航栏
    func setNavbar(){

        let CustomNavItem = self.navigationItem
       
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索景点")
        CustomNavItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "scanning"), style: .done, target: self, action: #selector(GetAdress))
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
        //tableView
        self.tableView.tableHeaderView=self.tableViewHead
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor().TransferStringToColor("D6D6D6")
        self.numberOfRowsInSection=8//显示的个数
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=140//行高
        //collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false

    }
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotCell
    cell.accessoryType = UITableViewCellAccessoryType.none
    cell.selectionStyle = .none
    return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableview ===",indexPath.row)
        let vc = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotMain", Identifier: "ScenicSpotMain") as! ScenicSpotMain
        self.navigationController?.show(vc, sender: self  )

        
    }
    // MARK: UILayoutDelegate,iOS 10之后需要在代理方法里实现
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    // size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 130, height: 120)
    }
    //sectin
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //row
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    //cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identiFier2, for: indexPath) as! HotScenicSpotCell
        cell.InitConfig("")
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectonView ===",indexPath.row)
        let vc = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotMain", Identifier: "ScenicSpotMain") as! ScenicSpotMain
        self.navigationController?.show(vc, sender: self  )
    }
}
