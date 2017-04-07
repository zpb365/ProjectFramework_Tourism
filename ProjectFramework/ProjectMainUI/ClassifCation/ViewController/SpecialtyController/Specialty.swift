//
//  Specialty.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class Specialty: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    let identiFier  = "SpecialtyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        //基控制器
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight)
        self.numberOfRowsInSection=8//显示的个数
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=120//行高
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#FF9635"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! SpecialtyCell
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 10
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("SpecialtyDetail", Identifier: "SpecialtyDetail") as! SpecialtyDetail
        self.navigationController?.show(vc, sender: self  )
    }
    // MARK: 设置导航栏
    func setNavbar(){
        
        let CustomNavItem = self.navigationItem
        
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索特产")
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        print("搜索")
    }
    
}
