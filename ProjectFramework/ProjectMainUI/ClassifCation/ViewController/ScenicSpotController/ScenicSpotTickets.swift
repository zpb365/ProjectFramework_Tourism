//
//  ScenicSpotTickets.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit


//自定义Cell返回父控制器跳转到日期选择
protocol PayForTicketDelegate {
    func push()
}

class ScenicSpotTickets: CustomTemplateViewController {

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
    var PayForTicketDelegate:PayForTicketDelegate?   //协议
    let identiFier  = "ScenicSpotTicketCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.footderView.setData(object: "", textArray: ["预定须知"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initUI() -> Void {
        self.InitCongif(tableView)
        self.tableView.frame = self.view.bounds
        self.numberOfSections = 1
        self.numberOfRowsInSection = 2
        self.tableViewheightForRowAt = 100
        self.tableView.tableFooterView = self.footderView
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotTicketCell
        cell.FuncCallbackValue {[weak self] (ticketType) in
            self?.PayForTicketDelegate?.push()
        }
        return cell
    }
    
}
