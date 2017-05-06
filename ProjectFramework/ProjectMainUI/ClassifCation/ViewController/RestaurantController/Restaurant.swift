//
//  Restaurant.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class Restaurant: CustomTemplateViewController,PYSearchViewControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    var Menuview:MenuView?=nil
    let identFier = "RestaurantCell"
    var siftViewModel       = SiftParmterViewModel()
    var viewModel           = RestaurantViewModel()
    var ChannelID           = 0
    var PageIndex: Int      = 1
    var PageSize:  Int      = 10
    var Title_Name          = ""
    var SalesPriorityEnum   = 1
    var ComprehensiveSortingEnum = 1
//    var isSearch: Bool      = false//是否为搜索，用来重置PageIndex，调不同接口
    var searchText: String? = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00BDD1"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    //视图即将消失
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#00BDD1"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏
        self.setNavbar()
        self.InitUI()
        self.getSiftDate()
    }
    //MARK: Refresh
    override func footerRefresh() {
        PageIndex = PageIndex + 1
        self.GetHtpsData()
        self.footer.endRefreshing()
    }
    override func headerRefresh() {
        self.footer.resetNoMoreData()
        self.remexParmeter(tag: true, searchText: "")
        self.header.endRefreshing()
    }
    //MARK: 获取筛选数据
    func getSiftDate() -> Void {
        siftViewModel.GetScreeningCondition(ChannelID:self.ChannelID) { (result) in
            if result == true{
                self.setMeunView()
                self.GetHtpsData()
            }
        }
    }
    //MARK: 获取数据
    func GetHtpsData() {
        viewModel.GetChannelsRestaurantList(SearchTitle: searchText!, ScreenTitle: Title_Name, SalesPriorityEnum: SalesPriorityEnum, ComprehensiveSortingEnum: ComprehensiveSortingEnum, PageIndex: PageIndex, PageSize: PageSize) { (result, NoMore,NoData) in
            if  result == true {
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
                    self.numberOfSections=1
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

    //MARK: InitUI
    func InitUI() -> Void{
        self.InitCongif(tableView)
        self.tableViewheightForRowAt=142//行高
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight+30, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight-30)
    }
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identFier, for: indexPath) as! RestaurantCell
        if viewModel.ListData.count > 0 {
            cell.InitConfig(viewModel.ListData[indexPath.row])
        }
        return cell        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("RestaurantDetail", Identifier: "RestaurantDetail") as! RestaurantDetail
        vc.RestaurantID = viewModel.ListData[indexPath.row].RestaurantID
        vc.ChannelID = ChannelID
        self.navigationController?.show(vc, sender: self  )
    }
    // MARK:    菜单栏
    func setMeunView(){
        Menuview=MenuView(delegate: self, frame:  CGRect(x: 0, y: 64, width: self.view.frame.width, height: 30))
        self.view.addSubview(Menuview!)
        
        let model1       = MenuModel()
        for   i:Int in 0  ..< (self.siftViewModel.ListData.ComprehensiveSorting?.count)!{
            let onemol   = OneMenuModel()
            onemol.type  = 1
            onemol.name  = self.siftViewModel.ListData.ComprehensiveSorting?[i].ComperhensiveSortingName
            onemol.value = self.siftViewModel.ListData.ComprehensiveSorting?[i].ComprehensiveSortingEnum.description
            model1.OneMenu.append(onemol)
        }
        
        let model2       = MenuModel()
        for   i:Int in 0  ..< (self.siftViewModel.ListData.SalesPriority?.count)!{
            let onemol   = OneMenuModel()
            onemol.type  = 2
            onemol.name  = self.siftViewModel.ListData.SalesPriority?[i].ComperhensiveSortingName
            onemol.value = self.siftViewModel.ListData.SalesPriority?[i].SalesPriorityEnum.description
            model2.OneMenu.append(onemol)
        }
        let model3       = MenuModel()
        for   i:Int in 0  ..< (self.siftViewModel.ListData.Screening?.count)!{
            let onemol   = OneMenuModel()
            onemol.name  = self.siftViewModel.ListData.Screening?[i].Screening
            for j:Int in 0 ..< (self.siftViewModel.ListData.Screening?[i].ScreeningItem?.count)! {
                let twomol   =  TowMenuModel()
                twomol.type  =  3
                twomol.name  =  self.siftViewModel.ListData.Screening?[i].ScreeningItem?[j].Title
                twomol.value =  self.siftViewModel.ListData.Screening?[i].ScreeningItem?[j].ID.description
                onemol.TowMenu.append(twomol)
            }
            model3.OneMenu.append(onemol)
        }
        
        Menuview?.AddMenuData(model1)
        Menuview?.AddMenuData(model2)
        Menuview?.AddMenuData(model3)
        //-----------------------刷新数据等操作在这个闭包执行-------------------------
        Menuview?.Callback_SelectedValue { [weak self](name, value,type) in
            print(name,value,type)
            switch type {
            case 1:
                self?.ComprehensiveSortingEnum = Int(value)!
                break;
            case 2:
                self?.SalesPriorityEnum = Int(value)!
                break;
            case 3:
                self?.Title_Name = name
                break;
            default:
                break;
            }
            
            self?.remexParmeter(tag: false, searchText: "")
        }
        Menuview?.menureloadData()    //刷新菜单 (每次加载完数据后都需要刷新
    }

    // MARK: 设置导航栏
    func setNavbar(){
        
        let CustomNavItem = self.navigationItem
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索餐厅")
        CustomNavItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "address"), style: .done, target: self, action: #selector(GetAdress))
    }
    // MARK: 搜索 && 当前地址
    func SearchEvent(){
        let searchViewController                 =   PYSearchViewController(hotSearches: nil, searchBarPlaceholder: "请输入您要查询的酒店")
        searchViewController?.hotSearchStyle     = .default
        searchViewController?.searchHistoryStyle = .normalTag
        searchViewController?.delegate=self
        let nav =  CYLBaseNavigationController (rootViewController: searchViewController!)
        self.present(nav, animated: false, completion: nil)
    }
    //PYSearchViewControllerDelegate 搜索时调用
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWithsearchBar searchBar: UISearchBar!, searchText: String!) {
        searchViewController.dismiss(animated: false) {
            self.remexParmeter(tag: true,searchText: searchText)
        }
    }
    //重置参数
    func remexParmeter(tag:Bool,searchText:String) -> Void {
        if tag == true {
            self.PageIndex                  = 1
            self.Title_Name                 = ""
            self.SalesPriorityEnum          = 1
            self.ComprehensiveSortingEnum   = 1
            self.searchText                 = searchText
            self.viewModel.ListData.removeAll()
            self.numberOfRowsInSection      = self.viewModel.ListData.count
            self.RefreshRequest(isLoading: true, isHiddenFooter: false,isLoadError: false)
            self.GetHtpsData()
        }
        else{
            self.viewModel.ListData.removeAll()
            self.numberOfRowsInSection = self.viewModel.ListData.count
            self.PageIndex                  = 1
            self.searchText = searchText
            self.RefreshRequest(isLoading: true, isHiddenFooter: false,isLoadError: false)
            self.GetHtpsData()
        }
    }

    func GetAdress() {
        print("当前地址")
    }


}
