//
//  ScenicSpot.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import SwiftTheme
import RxSwift
import RxCocoa

class ScenicSpot: CustomTemplateViewController,PYSearchViewControllerDelegate{
    
    lazy var tabButton: UIButton = {
        let tabButton = UIButton.init(type: .custom)
        tabButton.frame = CGRect.init(x: 0, y: 64, width: CommonFunction.kScreenWidth, height: 30)
        tabButton.layer.borderWidth = 0.6
        tabButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        tabButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -30, bottom: 0, right: 0)
        tabButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 65, bottom: 0, right: 0)
        tabButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        tabButton.setTitle("标签", for: .normal)
        tabButton.setImage(UIImage.init(named: "arrow_down"), for: .normal)
        tabButton.setTitleColor(UIColor().TransferStringToColor("#00ABEE"), for: .normal)
        tabButton.rx.tap.subscribe(      //返回
            onNext: { [weak self] value in
            self?.siftView.isHidden = !((self?.siftView.isHidden)!)
        }).addDisposableTo(self.disposeBag)
        return tabButton

    }()
    lazy var siftView: ScenicSiftView = {
        let siftView = ScenicSiftView.init(frame: CGRect.init(x: 0, y: 94, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 94))
        siftView.isHidden = true
        siftView.FuncCallbackValue(value: {[weak self] (tabName) in
            self?.tabName = tabName
            self?.GetHtpsData()
        })
        return siftView
    }()
    @IBOutlet weak var tableView: UITableView!//景点、景区数据
    let identiFier     = "ScenicSpot"
    var viewModel      = ScenicSpotViewModel()
    var tabViewModel   = TabParmterViewModel()
    var PageIndex: Int = 1
    var PageSize:  Int = 10
    var ChannelID      = 0
    var isSearch: Bool = false//是否为搜索，用来重置PageIndex，调不同接口
    var searchText: String? = nil
    var tabName = ""
    fileprivate let disposeBag   = DisposeBag() //创建一个处理包（通道）
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00ABEE"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00ABEE"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.GettTabData()
//        self.GetHtpsData()
        self.setNavbar()
        self.initUI()
        
    }
    //MARK: Refresh
    override func footerRefresh() {
        PageIndex = PageIndex + 1
        
        if isSearch {
            self.GetSearchData()
        }else{
            self.GetHtpsData()
        }
        self.footer.endRefreshing()
    }
    override func headerRefresh() {
        self.footer.resetNoMoreData()
        PageIndex = 1
        isSearch = true
        self.GetHtpsData()
        self.header.endRefreshing()
    }
    override func Error_Click() {
        PageIndex = 1
        isSearch = true
        self.GetHtpsData()
    }
    //MARK: 获取标签数据
    private func GettTabData() -> Void {
        tabViewModel.GetTabList(ChannelID: self.ChannelID, tabClassID: 0) { (result) in
            if  result == true {
                self.siftView.initUI(self.tabViewModel.ListData)
                self.GetHtpsData()
            }else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    //MARK:获取数据
    func GetHtpsData() {
        
        viewModel.GetChannelsScenicList(PageIndex: PageIndex, PageSize: PageSize,tabName:self.tabName) { (result,NoMore, NoData) in
            
            if  result == true {
                self.tableView.tableHeaderView = UIView().headView(width: CommonFunction.kScreenWidth, height: 35, leftViewColor: UIColor().TransferStringToColor("#26C6DA"), title: "景区", titleColor: UIColor.black)
                //没有数据
                if NoData == true{
                    self.RefreshRequest(isLoading: false,isHiddenFooter: true)
                    return
                }
                
                if(NoMore==true){
                    self.footer.endRefreshingWithNoMoreData()
                    self.RefreshRequest(isLoading: false, isHiddenFooter: false)
                }else{
                    self.numberOfRowsInSection = self.viewModel.ListData.count
                    self.numberOfSections=1//显示行数
                    //数据小于pagesize
                    if self.viewModel.ListData.count < self.PageSize{
                        self.footer.endRefreshingWithNoMoreData()
                    }
                    self.RefreshRequest(isLoading: false, isHiddenFooter: false)
                }
            }
            else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
            print("当前数组个数\(self.viewModel.ListData.count)")
        }
        
    }
    func GetSearchData(){
        viewModel.GetChannelsScenicList(ChannelID: self.ChannelID, Title: searchText!, PageIndex: PageIndex, PageSize: PageSize) { (result, NoMore) in
            if  result == true {
                if(NoMore==true){
                    self.footer.endRefreshingWithNoMoreData()
                }else{
                    self.numberOfRowsInSection = self.viewModel.ListData.count
                    if self.viewModel.ListData.count == 0 {
                        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                    }else{
                        self.RefreshRequest(isLoading: false, isHiddenFooter: false)
                    }
                }
            }
            else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
            print("搜索出数组个数\(self.viewModel.ListData.count)")
        }
    }
    // MARK: 设置导航栏
    func setNavbar(){

        let CustomNavItem                = self.navigationItem
        CustomNavItem.titleView          = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索景点")
        CustomNavItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "address"), style: .done, target: self, action: #selector(GetAdress))
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        
        isSearch = true
        PageIndex = 1
        
        let searchViewController                 =   PYSearchViewController(hotSearches: nil, searchBarPlaceholder: "请输入您要查询的景点、景区")
        searchViewController?.hotSearchStyle     = .default
        searchViewController?.searchHistoryStyle = .normalTag
        searchViewController?.delegate=self
        let nav =  CYLBaseNavigationController (rootViewController: searchViewController!)
        self.present(nav, animated: false, completion: nil)

    }
    func GetAdress() {
        //跳转到地图
        let vc = PublicMapShowListViewController()
        var  model  = [MapListModel]()
        for   item in viewModel.ListData {
            if(item.Lng==""||item.Lng==""){
                continue
            }
            let mapmodel = MapListModel()
            mapmodel.lat = item.Lat
            mapmodel.lng = item.Lng
            mapmodel.title = item.ScenicName
            model.append(mapmodel)
        }
        vc.models=model
        self.navigationController?.show(vc, sender: self)
    }
    //PYSearchViewControllerDelegate 搜索时调用
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWithsearchBar searchBar: UISearchBar!, searchText: String!) {
        searchViewController.dismiss(animated: false) {
            self.PageIndex = 1
            self.searchText = searchText
            self.GetSearchData()
            print("结束了")
        }
    }
    // MARK: initUI
    func initUI(){
        self.view.addSubview(self.tabButton)
        //基控制器
        self.InitCongif(tableView)
        self.tableView.frame           = CGRect.init(x: 0, y: 64 + 30, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 64 - 30)
        //tableView
        self.tableView.separatorStyle  = .singleLine
        self.tableView.separatorColor  = UIColor().TransferStringToColor("D6D6D6")
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=100//行高
        self.view.addSubview(siftView)
    }
    
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ScenicSpotCell
        cell.InitConfig(self.viewModel.ListData[indexPath.row])
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotMain", Identifier: "ScenicSpotMain") as! ScenicSpotMain
        vc.ScenicID = self.viewModel.ListData[indexPath.row].ScenicID
        self.navigationController?.show(vc, sender: self  )
    }
    
}
