//
//  SreetDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/7/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SreetDetail: CustomTemplateViewController {
    
    lazy var customWeb: PulickWebView = {
        let customWeb = PulickWebView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 50))
        customWeb.FuncCallbackValue { [weak self] (height) in
            self?.customWeb.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: height)
            self?.height = height
            self?.RefreshRequest(isLoading: false, isHiddenFooter: true)
        }
        return customWeb
    }()
    lazy var lable: UILabel = {
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 30))
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.textAlignment = .center
        lable.text = "街区详情"
        lable.textColor = UIColor.white
        lable.alpha = 0.0
        return lable
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var miaoshu: UILabel!
    @IBOutlet weak var headerView: UIView!

    fileprivate var backBtn:UIButton!=nil
    fileprivate var alph: CGFloat = 0
    fileprivate var CustomNavBar:UINavigationBar!=nil
    fileprivate var height: CGFloat = 50
    fileprivate var viewModel = SreetDetailViewModel()
    var StreetID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        self.initUI()
        self.GetHtpsData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func Error_Click() {
        self.numberOfRowsInSection = 0
        self.RefreshRequest(isLoading: true, isHiddenFooter: true)
        GetHtpsData()
    }
    //MARK: GetHtpsData
    private func GetHtpsData() -> Void {
        viewModel.GetChannelsCharacteristicStreetDetails(StreetID: StreetID) { (result) in
            if result == true{
                self.numberOfSections = 1
                self.numberOfRowsInSection = 1
                self.headerView.isHidden = false
                self.customWeb.isHidden = false
                self.iamgeView.ImageLoad(PostUrl: HttpsUrlImage + self.viewModel.ListData.CoverPhoto)
                self.miaoshu.text=self.viewModel.ListData.ShortDescription
                self.name.text = self.viewModel.ListData.StreetName
                self.address.text = "地址: " + self.viewModel.ListData.Address
                self.customWeb.loadHtmlString(html: self.viewModel.ListData.StreetContent)
                //计算高度
                let height_ = self.viewModel.ListData.ShortDescription.ContentSize(font: UIFont.systemFont(ofSize: 13), maxSize: CGSize.init(width: self.miaoshu.frame.width, height: 0)).height
                self.headerView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: self.miaoshu.frame.origin.y + height_ + 10)
                self.miaoshu.frame = CGRect.init(x: self.miaoshu.frame.origin.x, y: self.miaoshu.frame.origin.y, width: self.miaoshu.frame.width, height: height_)
                
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)

            }else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
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
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let offset: CGFloat = scrollView.contentOffset.y
        if (offset <= 64) {
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor().withAlphaComponent(0), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray
            UIView.animate(withDuration: 0.2, animations: {
                self.lable.alpha = 0.0
            })
        }
        else{
            alph = 1-((200 - offset)/200)
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color:  CommonFunction.SystemColor().withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
            lable.alpha = alph
        }
        
        //放大TableView头部图片
        if (offset < 0) {
            var rect = self.iamgeView.frame
            rect.origin.y = offset
            rect.size.height = 130-offset
            self.iamgeView.frame = rect
            self.tableView.tableHeaderView?.clipsToBounds = false
        }
    }

    //MARK: initUI
    func initUI() -> Void {
        self.iamgeView.clipsToBounds = true
        self.iamgeView.contentMode = .scaleAspectFill
        self.headerView.isHidden = true
        self.customWeb.isHidden = true
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        //基控制器
        self.InitCongif(tableView)
        self.tableView.tableHeaderView = headerView   //赋值头部
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight-49)
        self.tableViewheightForRowAt=0//行高
        self.header.isHidden=true
    }
    //MARK: 设置导航栏
    func setNavBar() -> Void{
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor().withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
        CustomNavBar.clipsToBounds=true
        self.view.addSubview(CustomNavBar)
        
        let CustomNavItem = UINavigationItem()
        //返回按钮
        backBtn = UIButton(type: .custom)
        backBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        backBtn.tag = 100
        backBtn.backgroundColor = UIColor.gray
        backBtn.layer.cornerRadius = 15
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        CustomNavItem.leftBarButtonItem=UIBarButtonItem.init(customView: backBtn)
        CustomNavItem.titleView = self.lable
        CustomNavBar.pushItem(CustomNavItem, animated: true)
        
    }
    //导航栏按钮方法
    func buttonClick(_ button: UIButton){
        _ = self.navigationController?.popViewController(animated: true)
    }


}