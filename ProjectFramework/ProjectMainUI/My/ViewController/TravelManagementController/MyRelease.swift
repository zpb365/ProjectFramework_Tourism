//
//  MyRelease.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyRelease:CustomTemplateViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    let identiFier = "MyReleaseCell"
    let viewModel=MyReleaseTravelViewModel()
    var isDelete:Bool=false
    var PageIndex: Int = 1
    var PageSize: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的发布"
        self.initUI()
        GetHtpsData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    //MARK: initUI
    func initUI() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: self.view.frame.height-CommonFunction.NavigationControllerHeight)
        self.InitCongif( self.tableView)
        self.numberOfSections=1 
        self.tableViewheightForRowAt=150//行高
        self.header.isHidden=true
    }
 
    //MARK: Refresh
    override func footerRefresh() {
        PageIndex = PageIndex + 1
        self.GetHtpsData()
    }
    
    //MARK: 获取数据
    func GetHtpsData() {
        isDelete=false
        viewModel.GetMyReleaseTravelsList(PageIndex: PageIndex, PageSize: PageSize) { (result,NoMore) in
            if  result == true {
                if(NoMore==true){
                    self.footer.endRefreshingWithNoMoreData()
                }else{
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
        GetHtpsData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath)as! MyReleaseCell
        cell.InitConfig(viewModel.ListData[indexPath.row] as Any)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("TravelDetail", Identifier: "TravelDetail") as! TravelDetail
        vc.TravelsId=viewModel.ListData[indexPath.row].TravelsId
        self.navigationController?.show(vc, sender: self  )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.viewModel.ListData.count
        if(count==0&&isDelete==true){
             isDelete=false
             self.RefreshRequest(isLoading: false, isHiddenFooter: true)
           
        }
        return count
    }
  
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        isDelete=true

        viewModel.DeleteMyTravels(TravelsID: viewModel.ListData[indexPath.row].TravelsId) { (result) in
            if(result==true){
                self.viewModel.ListData.remove(at: indexPath.row)
              tableView.deleteRows(at: [IndexPath(row:indexPath.row, section: 0)], with: .left)
            }else{
                CommonFunction.HUD("删除失败", type: .error)
            }
        }
        
        
   
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
