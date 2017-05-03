//
//  ScenicSpotTickets.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit


////自定义Cell返回父控制器跳转到日期选择
//protocol PayForTicketDelegate {
//    func push()
//}

class ScenicSpotTickets: CustomTemplateViewController,ScrollEnabledDelegate {

    lazy var footderView: PulickIntroduceView = {
        let footderView = PulickIntroduceView()
        footderView.createTableView(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
        footderView.FuncCallbackValue(value: { [weak self](height) in
            self?.footderView.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height)
            self?.footderView.customTableView.frame = (self?.footderView.bounds)!
            self?.tableView.reloadData()
        })
        return footderView
    }()
    
    @IBOutlet weak var tableView: UITableView!
//    var PayForTicketDelegate:PayForTicketDelegate?//协议
    let identiFier  = "ScenicSpotTicketCell"
    var dataArray:[ScenicTicketList]?
    var ScenicID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
//        self.footderView.setData(object: "", textArray: ["预定须知"])
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
        
    }

    func initUI() -> Void {
//        print((self.dataArray?.count)!)
        
        self.InitCongif(tableView)
        self.tableView.frame = self.view.bounds
        self.numberOfSections = 1
        self.numberOfRowsInSection = (self.dataArray?.count)!
        self.tableViewheightForRowAt = 100
        self.header.isHidden = true
//        self.tableView.tableFooterView = self.footderView
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotTicketCell
        cell.InitConfig(self.dataArray?[indexPath.row] as Any)
        cell.FuncCallbackValue {[weak self] (model) in
            let vc = ScenicSpotDateChoose()
            vc.ScenicID = (self?.ScenicID)!//景区id
//            vc.ScenicProductID = (self?.dataArray?[indexPath.row].ScenicProductID)!//票id
            vc.ticketItem = self?.dataArray![indexPath.row]
            self?.present(vc, animated: true, completion: {
                
            })
        }
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
        debugPrint("购票 页面已经销毁")
    }
}
