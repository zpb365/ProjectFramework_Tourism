//
//  PolicyNews.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class PolicyNews: CustomTemplateViewController {
    @IBOutlet weak var tableView: UITableView!

//    lazy var sectionView: UIView = {
//        let sectionView = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
//        sectionView.backgroundColor = UIColor.white
//        return sectionView
//    }()
//    lazy var lable: UILabel = {
//        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: 30))
//        lable.backgroundColor = UIColor().TransferStringToColor("#738FFE")
//        lable.textAlignment = .center
//        lable.font = UIFont.systemFont(ofSize: 12)
//        lable.textColor = UIColor.white
//        lable.layer.cornerRadius = 5
//        lable.clipsToBounds = true
//        return lable
//    }()
    
    let identiFier = "PolicyNewsCell"
    
    let sectionArray = ["政策法规","行业信息","景区公告","通知公告"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        self.initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: 设置导航栏
    func setNavbar(){
        
        let CustomNavItem = self.navigationItem
        
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索信息公告")
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        print("搜索")
    }
    //MARK: initUI
    func initUI() -> Void {
        
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y:CommonFunction.NavigationControllerHeight, w: self.view.frame.width, h: self.view.frame.height - CommonFunction.NavigationControllerHeight)
        self.tableViewheightForRowAt = 40
        
    }
    //MARK: tableViewDelegate
    //组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    var _numberOfRowsInSection = [4,5,5,8]
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _numberOfRowsInSection[section]
    }
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
        sectionView.backgroundColor = UIColor.white
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: 30))
        lable.backgroundColor = UIColor().TransferStringToColor("#FF7043")
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.textColor = UIColor.white
        lable.layer.cornerRadius = 5
        lable.clipsToBounds = true
        lable.text = sectionArray[section]
        lable.center = sectionView.center
        sectionView.addSubview(lable)
        return sectionView
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! PolicyNewsCell
        return cell
    }
}
