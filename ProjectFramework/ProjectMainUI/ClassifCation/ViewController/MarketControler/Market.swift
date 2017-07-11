//
//  Market.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/7/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class Market: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let identiFier = "MarketListCell"
    fileprivate var ViewModel = MarketViewModel()
    fileprivate var PageIndex: Int = 1
    fileprivate var PageSize:  Int = 10
    fileprivate var tabName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.GetHtpsData()
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Refresh
    override func footerRefresh() {
        PageIndex = PageIndex + 1
        self.GetHtpsData()
        
    }
    override func headerRefresh() {
        self.footer.resetNoMoreData()
        PageIndex = 1
        self.GetHtpsData()
        
    }
    override func Error_Click() {
        self.numberOfRowsInSection = 0
        self.RefreshRequest(isLoading: true, isHiddenFooter: true)
        GetHtpsData()
    }
    //MARK: 获取数据
    private func GetHtpsData() -> Void {
        ViewModel.GetChannelsMarketList(PageIndex: PageIndex, PageSize: PageSize, tabName: tabName) { (result, NoMore) in
            self.header.endRefreshing()
            self.footer.endRefreshing()
            if result == true {
                
                if(NoMore==true){
                    self.footer.endRefreshingWithNoMoreData()
                    self.RefreshRequest(isLoading: false, isHiddenFooter: false)
                }else{
                    self.numberOfRowsInSection = self.ViewModel.ListData.count
                    self.numberOfSections=1//显示行数
                    //数据小于pagesize
                    if self.ViewModel.ListData.count < self.PageSize{
                        self.footer.endRefreshingWithNoMoreData()
                    }
                    self.RefreshRequest(isLoading: false, isHiddenFooter: false)
                }
            }else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
            
            
        }
    }
    //MARK: tableViewdelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! MarketListCell
        cell.InitConfig(self.ViewModel.ListData[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("MarketDtail", Identifier: "MarketDtail") as! MarketDtail
        vc.MarketID = self.ViewModel.ListData[indexPath.row].MarketID
        self.navigationController?.show(vc, sender: self  )
    }
    //MARK: 构造UI
    private func initUI() -> Void {
        self.InitCongif(tableView)
        tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight)
        self.tableViewheightForRowAt=130//行高
    }
}
