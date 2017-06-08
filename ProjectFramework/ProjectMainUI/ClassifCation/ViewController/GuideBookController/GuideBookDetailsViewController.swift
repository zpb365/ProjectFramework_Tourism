//
//  GuideBookDetailsViewController.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GuideBookDetailsViewController: CustomTemplateViewController {
    
    @IBOutlet weak var HeadView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var CoverPhoto: UIImageView!
    
    @IBOutlet weak var CiceroneName: UILabel!
    
    @IBOutlet weak var Photoshadow: UILabel!    //图片阴影
    @IBOutlet weak var WorkingYears: UILabel!
    
    @IBOutlet weak var Language: UILabel!
    
    @IBOutlet weak var CertificateID: UILabel!
    
    @IBOutlet weak var ServiceArea: UILabel!
    
    @IBOutlet weak var Autograph: UILabel!
    
    @IBOutlet weak var Selfintroduction: UILabel!
    
    @IBOutlet weak var ImageList: UILabel!
    @IBOutlet weak var baseImageView: UIImageView!
    
    fileprivate var CustomNavBar:UINavigationBar!=nil
    fileprivate var height: CGFloat = 50
    fileprivate var viewModel = GuideBookDetailViewModel()
    fileprivate var alph: CGFloat = 0
    fileprivate var backBtn:UIButton!=nil
    var CiceroneID=0    //传进来的参数
    
    let identiFier  = "GuideBookDetailsCell"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        self.initUI()
        GetHtpsData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: 获取数据
    func GetHtpsData() {
        HeadView.isHidden=true
        viewModel.GetChannelsCiceroneDetails(CiceroneID: self.CiceroneID) { (result) in
            
            if  result == true {
                if(self.viewModel.ListData.CiceroneID==0){  //判断没有数据
                    self.numberOfRowsInSection = 0
                    self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                    return
                }
                self.HeadView.isHidden=false
                self.CoverPhoto.isUserInteractionEnabled=true
                self.CoverPhoto.ImageLoad(PostUrl: HttpsUrlImage+self.viewModel.ListData.CoverPhoto)
                self.CiceroneName.text="导游姓名: "+self.viewModel.ListData.CiceroneName
                self.WorkingYears.text="带团时间: "+self.viewModel.ListData.WorkingYears
                self.Language.text="语言: "+self.viewModel.ListData.Language
                self.CertificateID.text="导游证: "+self.viewModel.ListData.CertificateID
                self.ServiceArea.text="擅长区域: "+self.viewModel.ListData.ServiceArea
                self.Autograph.text="个性签名: "+self.viewModel.ListData.Autograph
                self.Selfintroduction.text="自我介绍: "+self.viewModel.ListData.Selfintroduction
                
                //高度自适应
                let height1 = ("个性签名: "+self.viewModel.ListData.Autograph).ContentSize(font: UIFont.systemFont(ofSize: 13), maxSize: CGSize.init(width: CommonFunction.kScreenWidth - 20, height: 0)).height
                let height2 = ("自我介绍: "+self.viewModel.ListData.Selfintroduction).ContentSize(font: UIFont.systemFont(ofSize: 13), maxSize: CGSize.init(width: CommonFunction.kScreenWidth - 20, height: 0)).height
                //重新设置坐标
                self.Autograph.frame = CGRect.init(x: 10, y: self.Autograph.frame.origin.y, width: CommonFunction.kScreenWidth - 20, height: height1)
                self.Selfintroduction.frame = CGRect.init(x: 10, y: self.Autograph.frame.origin.y + height1 + 5, width: CommonFunction.kScreenWidth - 20, height: height2)
                self.HeadView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: self.Selfintroduction.frame.origin.y  + height2 + 10)
                self.tableView.tableHeaderView = self.HeadView   //赋值头部
                if(self.viewModel.ListData.ImageList.count==0){
                      self.ImageList.isHidden=true
                    self.Photoshadow.isHidden=true
                }else{
                    self.ImageList.text=self.viewModel.ListData.ImageList.count.description+"张" 
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))  //添加图片点击事件
                    self.CoverPhoto.addGestureRecognizer(tapGesture)
                }
                
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
        self.RefreshRequest(isLoading: true, isHiddenFooter: true)
        GetHtpsData()
    }
    
    
    //MARK: initUI
    func initUI() -> Void {
        //背景图可拉伸
        self.baseImageView.clipsToBounds = true
        self.baseImageView.contentMode = .scaleAspectFill
        //基控制器
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height )
        self.numberOfSections=1//显示行数 
        self.header.isHidden=true
    }
    
    //MARK: 设置导航栏
    func setNavBar() -> Void{
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#009689").withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
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
        CustomNavBar.pushItem(CustomNavItem, animated: true)
    }
    
    //导航栏按钮方法
    func buttonClick(_ button: UIButton){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //拨打电话
    @IBAction func CallPhone(_ sender: Any) {
        if(Global_UserInfo.IsLogin==true){
            CommonFunction.CallPhone(self, number: viewModel.ListData.Phone)
        }else{
            CommonFunction.HUD("请登录", type: .error)
        }
    }
    func handleTapGesture(){
        var Imagelist = Array<String>()//图片组
        var ImageTab  = Array<String>()//标签组
        for i in 0..<(viewModel.ListData.ImageList.count){
            let model = viewModel.ListData.ImageList?[i]
            Imagelist.append(HttpsUrlImage+model!.PhotoUrl)
            ImageTab.append(model!.PhotoDescribe)
        }
        
        let vc = ImagePreviewViewController( ImageUrlList: Imagelist,IsDescribe: true,DescribeList: ImageTab )
        self.navigationController?.pushViewController(vc, animated: true )
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let offset: CGFloat = scrollView.contentOffset.y
        if (offset <= 64) {
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#009689").withAlphaComponent(0), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray
        }
        else{
            alph = 1-((200 - offset)/200)
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#009689").withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph) 
        }
        //放大TableView头部图片
        if (offset < 0) {
            var rect = self.baseImageView.frame
            rect.origin.y = offset
            rect.size.height = 130-offset
            self.baseImageView.frame = rect
            self.tableView.tableHeaderView?.clipsToBounds = false
        }
    }
    
    var isfirst2: Bool = false
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! GuideBookDetailsViewCell
        if viewModel.ListData.Introduce != "" {
            cell.InitConfig("")
            cell.loadHtmlString(html: self.viewModel.ListData.Introduce, isFirst: isfirst2)
            isfirst2 = true
            cell.FuncCallbackValue(value: {[weak self] (height) in
                self?.height = height
                self?.RefreshRequest(isLoading: false, isHiddenFooter: true)
            })
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return height > 50 ? height : 50
    }
    
}
