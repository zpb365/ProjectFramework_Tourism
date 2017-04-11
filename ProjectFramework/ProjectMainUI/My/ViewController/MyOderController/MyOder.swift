//
//  MyOder.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOder: CustomTemplateViewController {

    lazy var topButtonBar: UIView = {
        let topButtonBar = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 64, w: CommonFunction.kScreenWidth, h: 40))
        topButtonBar.backgroundColor = UIColor.white
        let titleArray: Array=["全部","已付款","待付款","待评价"]
        for i in 0..<titleArray.count {
            let title = titleArray[i]
            let button = UIButton.init(type: .system)
            let frame_x = CGFloat((CommonFunction.kScreenWidth/CGFloat(titleArray.count))*CGFloat(i))
            button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:CommonFunction.kScreenWidth / CGFloat(titleArray.count) , h: 35)
            button.tag = 1 + i
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.black, for: .normal)
//            button.setTitleColor(UIColor().TransferStringToColor("#03A9F4"), for: .selected)
            
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
    
    var currentBtn = UIButton()
    let identiFier = "MyOderCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after loading the view.
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
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y: 104, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight - 104)
        self.numberOfRowsInSection = 50
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt = 155
    }
    //MARK: tableViewDelegate
    //数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath)as! MyOderCell
        cell.InitConfig("")
        cell.FuncCallbackValue { 
            let vc = CommonFunction.ViewControllerWithStoryboardName("OderComment", Identifier: "OderComment") as! OderComment
            self.navigationController?.show(vc, sender: self  )
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("OderDetail", Identifier: "OderDetail") as! OderDetail
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
        }
    }
}
