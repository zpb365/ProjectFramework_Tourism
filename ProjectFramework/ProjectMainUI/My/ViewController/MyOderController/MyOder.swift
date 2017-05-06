//
//  MyOder.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOder: CustomTemplateViewController {
    
    var currentBtn = UIButton()     //currentBtn.tag  = 0 表示全部  1表示已付款  2 表示待付款  3待评价
    lazy var topButtonBar: UIView = {
        let topButtonBar = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 64, w: CommonFunction.kScreenWidth, h: 40))
        topButtonBar.backgroundColor = UIColor.white
        let titleArray: Array=["全部","已付款","待付款","待评价"]
        for i in 0..<titleArray.count {
            let title = titleArray[i]
            let button = UIButton.init(type: .system)
            let frame_x = CGFloat((CommonFunction.kScreenWidth/CGFloat(titleArray.count))*CGFloat(i))
            button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:CommonFunction.kScreenWidth / CGFloat(titleArray.count) , h: 35)
            button.tag = i
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.black, for: .normal)
 
            button.addTarget(self, action:#selector(headerClick), for: .touchUpInside)
            
            if (i == 0) {
                button.setTitleColor(UIColor().TransferStringToColor("#03A9F4"), for: .normal)
                self.currentBtn = button
                let bottomLine = UIView()
                bottomLine.tag = 666
                bottomLine.frame = CommonFunction.CGRect_fram(0, y: 35, w: 50, h: 2)
                bottomLine.center.x = button.center.x
                bottomLine.backgroundColor = UIColor().TransferStringToColor("#03A9F4")
                topButtonBar.addSubview(bottomLine)
            }
            topButtonBar.addSubview(button)
        }
        return topButtonBar
    }()
    
  
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = MyOrderViewModel()
    let identiFier = "MyOderCell"
    var IsLoadUI=false  //是否加载ui
    var PageIndex: Int = 1
    var PageSize: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initUI()
        headerRefresh()
    }
    

    //MARK: Refresh
    override func footerRefresh() {
        PageIndex = PageIndex + 1
        self.GetHtpsData()
    }
     //MARK: Refresh
    override func headerRefresh() {
        PageIndex = 1
        viewModel.ListData.removeAll()
        self.numberOfRowsInSection=viewModel.ListData.count
        self.RefreshRequest(isLoading: true, isHiddenFooter: true )
        GetHtpsData()
    }
    
    //MARK: 获取数据
    func GetHtpsData() {
       
        viewModel.GetMyOrderList(OrderType:currentBtn.tag,PageIndex: PageIndex, PageSize: PageSize) { (result,NoMore) in
            self.header.endRefreshing()
            if  result == true {
                if(NoMore==true){
                    self.footer.endRefreshingWithNoMoreData()
                }else{
                    self.numberOfRowsInSection=self.viewModel.ListData.count
                    if(self.viewModel.ListData.count==0){
                        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                        return
                    }
                    if(self.numberOfRowsInSection  < self.PageSize ){
                         self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                        return
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
        self.numberOfRowsInSection=viewModel.ListData.count
        GetHtpsData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        self.title = "我的订单"
        self.view.addSubview(topButtonBar)
        
    }
    //MARK: initUI
    func initUI() -> Void {
        if(IsLoadUI==true){
            return
        }
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y: 104, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight - 104) 
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt = 150
        IsLoadUI=true
    }
    //MARK: tableViewDelegate
    //数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath)as! MyOderCell
        cell.InitConfig(viewModel.ListData[indexPath.row])
        cell.FuncCallbackValue {[weak self] (OrderType) in
            if(OrderType==0){//待付款
              let vc =   PayClass(parameters: ["OrderNumber":(self?.viewModel.ListData[indexPath.row].OrderNumber)!],Channels: 0) 
                self?.present(vc, animated: false, completion: nil)
            }
            if(OrderType==1){//待评价
                let vc = CommonFunction.ViewControllerWithStoryboardName("OderComment", Identifier: "OderComment") as! OderComment
                vc._OrderNumber=(self?.viewModel.ListData[indexPath.row].OrderNumber)!
                self?.navigationController?.show(vc, sender: self  )
            }
        }
      
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("OderDetail", Identifier: "OderDetail") as! OderDetail
        vc.OrderNumber=viewModel.ListData[indexPath.row].OrderNumber
        vc._MyOrderModel=viewModel.ListData[indexPath.row]
        self.navigationController?.show(vc, sender: self  )
    }
    //MARK: headerClick
    func headerClick(_ button: UIButton){
        //底部线滑动
        UIView.animate(withDuration: 0.3) {
            let line = self.topButtonBar.viewWithTag(666)
            line?.center.x = button.center.x
            button.setTitleColor(UIColor().TransferStringToColor("#03A9F4"), for: .normal)
            self.currentBtn.setTitleColor(UIColor.black, for: .normal)
            self.currentBtn = button
            self.headerRefresh()
        }
        
    }
}
