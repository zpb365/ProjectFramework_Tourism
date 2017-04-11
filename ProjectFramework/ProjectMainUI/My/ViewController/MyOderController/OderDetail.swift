//
//  OderDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class OderDetail: CustomTemplateViewController {

    lazy var bottomBar: UIView = {
        let bottomBar = UIView.init(frame: CommonFunction.CGRect_fram(0, y: CommonFunction.kScreenHeight - 40, w: CommonFunction.kScreenWidth, h: 40))
        bottomBar.backgroundColor = UIColor().TransferStringToColor("#F8F8F8")
        bottomBar.layer.borderWidth = 0.5
        bottomBar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        
        let payLable = UILabel.init(frame: CommonFunction.CGRect_fram(5, y: (40 - 15)/2, w: 75, h: 15))
        payLable.font = UIFont.systemFont(ofSize: 13)
        payLable.text = "支付金额"
        payLable.textColor = UIColor.gray
        bottomBar.addSubview(payLable)
        
        return bottomBar
    }()
    
    //支付金额
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel.init(frame: CommonFunction.CGRect_fram(80, y: (40 - 15)/2, w: 100, h:15 ))
        priceLabel.font = UIFont.systemFont(ofSize: 13)
        priceLabel.text = "¥999"
        priceLabel.textColor = UIColor().TransferStringToColor("#FF5722")
        return priceLabel
    }()
    
    lazy var typeButton: UIButton = {
        let typeButton = UIButton.init(type: .system)
        typeButton.frame = CommonFunction.CGRect_fram(CommonFunction.kScreenWidth - 90, y: 0, w: 90, h: 40)
        typeButton.backgroundColor = UIColor().TransferStringToColor("#FF5722")
        typeButton.setTitle("待评价", for: .normal)
        typeButton.setTitleColor(UIColor.white, for: .normal)
        typeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        typeButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return typeButton
    }()
    
    
    @IBOutlet weak var tabbleView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    let identiFier = "OderContactCell"
    var keyArray = ["联系人","联系电话","备注"]
    var ValueArray = ["黄朝艺","1888888888","很棒"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: initUI
    func initUI() -> Void {
        self.title = "订单详情"
        
        self.InitCongif(self.tabbleView)
        self.tabbleView.frame = CommonFunction.CGRect_fram(0, y: 64, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight - 64 - 40)
        self.numberOfSections = 1
        self.numberOfRowsInSection = 3
        self.tableViewheightForRowAt = 40
        self.header.isHidden = true
        self.Backfooter.isHidden = true
        self.tabbleView.tableHeaderView = tableViewHead
        self.tabbleView.tableFooterView = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 0.001))
        self.view.addSubview(self.bottomBar)
        self.bottomBar.addSubview(self.priceLabel)
        self.bottomBar.addSubview(self.typeButton)
        self.tabbleView.reloadData()
        self.footer.isHidden=true
    }
    //MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! OderContactCell
        cell.setCell(key: keyArray[indexPath.row], value: ValueArray[indexPath.row])
        return cell
    }
    //MARK: 支付类型
    func buttonClick(_ button: UIButton) -> Void {
        let vc = CommonFunction.ViewControllerWithStoryboardName("OderComment", Identifier: "OderComment") as! OderComment
        self.navigationController?.show(vc, sender: self  )
        print("待评价")
    }
}
