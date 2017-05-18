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


    
    let identiFier = "PolicyNewsCell"
    
    let sectionArray = ["政策法规","行业信息","景区公告","通知公告"]
    var viewModel = PolicyNewsViewMdeel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setNavbar()
        self.initUI()
        GetHtpsData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func GetHtpsData() -> Void {
        viewModel.GetChannelsNews(result: { (result) in
            if  result == true {
                self.numberOfSections = self.viewModel.ListData.count
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                
            }else{
                
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        })
    }
    
    override func Error_Click() {
        self.GetHtpsData()
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

    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ListData[section].News!.count
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
        lable.text = viewModel.ListData[section].NewsTypeName
        lable.center = sectionView.center
        sectionView.addSubview(lable)
        return sectionView
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! PolicyNewsCell
        cell.InitConfig(viewModel.ListData[indexPath.section].News?[indexPath.row] as Any)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InformationViewController()    //点击智慧头条的cell
        vc.title = viewModel.ListData[indexPath.section].News![indexPath.row].Title
        vc.Content = viewModel.ListData[indexPath.section].News![indexPath.row].NewsContent
        self.navigationController?.show(vc, sender: self)
    }
    

}
