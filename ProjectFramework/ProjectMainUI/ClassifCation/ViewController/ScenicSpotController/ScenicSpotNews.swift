//
//  ScenicSpotNews.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotNews: CustomTemplateViewController,ScrollEnabledDelegate {

    @IBOutlet weak var tableView: UITableView!
    let identifier = "ScenicSpotHomeNewsCell"
    var ScenicNewsModel: ScenicNews_Item?=nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
    }

    func initUI() -> Void {
        tableView.register(UINib(nibName: "ScenicSpotHomeNewsCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.InitCongif(self.tableView)
        if self.ScenicNewsModel?.News == nil {
            self.numberOfSections = 0
        }else{
            self.numberOfSections = (self.ScenicNewsModel?.News?.count)!
        }
        self.tableViewheightForRowAt = 35
        self.tableView.isScrollEnabled = false
        self.tableView.frame = self.view.bounds
        self.header.isHidden = true
//        self.tableView.tableHeaderView = UIView().headView(width: CommonFunction.kScreenWidth, height: 35, leftViewColor: UIColor().TransferStringToColor("#00ABEE"), title: "景区公告", titleColor: UIColor.black)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ScenicNewsModel != nil{
            return (self.ScenicNewsModel!.News![section].ScenicNews?.count)!
        }else{
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 35
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if ScenicNewsModel != nil{
            return UIView().headView(width: CommonFunction.kScreenWidth, height: 35, leftViewColor: UIColor().TransferStringToColor("#00ABEE"), title: (self.ScenicNewsModel?.News![section].NewsClassName)!, titleColor: UIColor.black)
        }else{
            return UIView()
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScenicSpotHomeNewsCell
        cell.InitConfig(self.ScenicNewsModel?.News?[indexPath.section].ScenicNews?[indexPath.row] as Any)
        return cell

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InformationViewController()    //点击智慧头条的cell
        vc.title = self.ScenicNewsModel?.News?[indexPath.section].ScenicNews?[indexPath.row].Title
        vc.Content = (self.ScenicNewsModel?.News?[indexPath.section].ScenicNews?[indexPath.row].NewsContent)!
        self.navigationController?.show(vc, sender: self)
    }
    //MARK: SlidingDelegate
    func ScrollEnabledCan() {
//        print("实现代理")
        self.tableView.isScrollEnabled = true
    }
    func ScrollEnabledNo() {
//        print("实现代理")
        self.tableView.isScrollEnabled = false
    }
    deinit {    //销毁页面
        debugPrint("资讯 页面已经销毁")
    }
}
