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

    lazy var footderView: PulickWebView = {
        let footderView = PulickWebView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 0))
        footderView.FuncCallbackValue(value: {[weak self] (height) in
            self?.footderView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: height)
            self?.tableView.tableFooterView = self?.footderView
            self?.RefreshRequest(isLoading: false, isHiddenFooter: true)
        })
        return footderView
    }()
    
    @IBOutlet weak var tableView: UITableView!
//    var PayForTicketDelegate:PayForTicketDelegate?//协议
    let identiFier  = "ScenicSpotTicketCell"
    var dataArray:[ScenicTicketList]?
    var ScenicID = 0
    var BookingNotes=""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
        
    }

    func initUI() -> Void {
//        print((self.dataArray?.count)!)
        
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 64 - 30)
        print(self.tableView.frame)
        if dataArray ==  nil {
            self.numberOfRowsInSection = 0
        }else{
            self.numberOfRowsInSection = (self.dataArray?.count)!
        }
        self.numberOfSections = 1
        self.tableViewheightForRowAt = 100
        self.header.isHidden = true
        if (self.dataArray?.count)! > 0 {
            self.tableView.tableFooterView = self.footderView
            self.footderView.loadHtmlString(html: self.BookingNotes)
        }
        let swp = UISwipeGestureRecognizer.init(target: self, action: #selector(sliding))
        swp.direction = .up
        self.view.addGestureRecognizer(swp)
    }
    @objc private func sliding() -> Void {
        self.ScrollEnabledCan()
        self.tableView.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
        print("我滑动了")
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotTicketCell
        cell.InitConfig(self.dataArray?[indexPath.row] as Any)
        cell.FuncCallbackValue {[weak self] (model) in
            //是否登录
            if(Global_UserInfo.IsLogin==false){
                let vc = LoginViewControllerTwo()
                self?.present(vc, animated: true, completion: nil)
                return
            }
            let vc = ScenicSpotDateChoose()
            vc.ScenicID = (self?.ScenicID)!//景区id
            vc.ticketItem = self?.dataArray![indexPath.row]
            self?.navigationController?.show(vc, sender: self)
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
