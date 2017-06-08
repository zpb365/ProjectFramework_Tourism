//
//  Travel.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import SnapKit

class Travel: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headView: UIView!
    
    let identiFier  = "TravelCell"
    var viewModel = TravelViewModel()
    var PageIndex: Int = 1
    var PageSize: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //基控制器
        self.InitCongif(tableView)
        self.headView.isHidden = true
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight-49)
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=150//行高
        self.header.isHidden=true
        GetHtpsData()
        
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
  
    
    //MARK: 获取数据
    func GetHtpsData() {
        
        viewModel.GetTravelsChannelsList(PageIndex: PageIndex, PageSize: PageSize) { (result,NoMore) in
            if  result == true {
                self.headView.isHidden = false
                self.tableView.tableHeaderView = self.headView
                if(NoMore==true){
                    self.footer.endRefreshingWithNoMoreData()
                }else{
                    self.numberOfRowsInSection = self.viewModel.ListData.count
                    if(self.viewModel.ListData.count==0){
                        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                        return
                    }
                    if(self.numberOfRowsInSection  < self.PageSize ){
                        self.footer.endRefreshingWithNoMoreData()
                    }
                    self.RefreshRequest(isLoading: false, isHiddenFooter: false)
                    
                }
            }
            else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    
    override func Error_Click() {
        PageIndex = 1
        viewModel.ListData.removeAll()
        self.numberOfRowsInSection = self.viewModel.ListData.count
        GetHtpsData()
    }
    
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! TravelCell
        cell.InitConfig(viewModel.ListData[indexPath.row] as Any)
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("TravelDetail", Identifier: "TravelDetail") as! TravelDetail
        vc.TravelsId=viewModel.ListData[indexPath.row].TravelsId
        self.navigationController?.show(vc, sender: self  )
    }
}
