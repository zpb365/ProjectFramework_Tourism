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
    var ScenicNewsModel = ScenicNews_Item()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
    }

    func initUI() -> Void {
        tableView.register(UINib(nibName: "ScenicSpotHomeNewsCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.InitCongif(self.tableView)
        self.numberOfSections = (self.ScenicNewsModel.News?.count)!
        self.tableViewheightForRowAt = 35
        self.tableView.isScrollEnabled = false
        self.tableView.frame = self.view.bounds
        self.header.isHidden = true
//        self.tableView.tableHeaderView = UIView().headView(width: CommonFunction.kScreenWidth, height: 35, leftViewColor: UIColor().TransferStringToColor("#00ABEE"), title: "景区公告", titleColor: UIColor.black)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.ScenicNewsModel.News![section].ScenicNews?.count)!
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 35
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView().headView(width: CommonFunction.kScreenWidth, height: 35, leftViewColor: UIColor().TransferStringToColor("#00ABEE"), title: self.ScenicNewsModel.News![section].NewsClassName, titleColor: UIColor.black)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScenicSpotHomeNewsCell
        cell.InitConfig(self.ScenicNewsModel.News?[indexPath.section].ScenicNews?[indexPath.row] as Any)
        return cell

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
