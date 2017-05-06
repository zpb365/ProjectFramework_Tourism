//
//  TravelDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelDetail: CustomTemplateViewController{
    
    lazy var customWeb: PulickWebView = {
        let customWeb = PulickWebView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 50))
        customWeb.FuncCallbackValue { [weak self] (height) in
            self?.customWeb.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: height)
            self?.height = height
            self?.RefreshRequest(isLoading: false, isHiddenFooter: true)
        }
        return customWeb
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    var CustomNavBar:UINavigationBar!=nil
    var height: CGFloat = 50
    var TravelsId=0
    var PageIndex: Int = 1
    var PageSize: Int = 10
    var viewModel = TravelDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        self.initUI()
        //基控制器
        self.InitCongif(tableView)
        self.tableView.tableHeaderView = BaseView   //赋值头部
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight-49)
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=150//行高
        self.header.isHidden=true
        GetHtpsData()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
 
    //MARK: initUI
    func initUI() -> Void {
        BaseView.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: contentLabel.frame.maxY + 20 )
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(-20)
            make.bottom.equalTo(0)
        }
    }
    
    
    //MARK: 获取数据
    func GetHtpsData() {
        
        viewModel.GetTravelsDetails(TravelsId: TravelsId,PageIndex: PageIndex, PageSize: PageSize) { (result) in
            
            if  result == true { 
                self.imageView.ImageLoad(PostUrl:  HttpsUrlImage+self.viewModel.ListData.CoverPhoto)
                self.contentLabel.text=self.viewModel.ListData.TravelsNote
                self.customWeb.loadHtmlString(html: self.viewModel.ListData.TravelsContent)
                self.numberOfRowsInSection = 1
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                
            }
            else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    
    override func Error_Click() {
        self.numberOfRowsInSection = 0
        GetHtpsData()
    }
    
    //MARK: 设置导航栏
    func setNavBar() -> Void{
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor.clear, size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
        CustomNavBar.clipsToBounds=true
        self.view.addSubview(CustomNavBar)
        
        let CustomNavItem = UINavigationItem()
        //返回按钮
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        backBtn.tag = 100
        backBtn.backgroundColor = UIColor.gray
        backBtn.layer.cornerRadius = 15
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        CustomNavItem.leftBarButtonItem=UIBarButtonItem.init(customView: backBtn)
        CustomNavBar.pushItem(CustomNavItem, animated: true)
    }
    //导航栏按钮方法
    func buttonClick(_ button: UIButton){
        _ = self.navigationController?.popViewController(animated: true)
    }
    //MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return self.customWeb
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return height > 50 ? height : 50
    }
}
