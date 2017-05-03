//
//  Conference.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class Conference: CustomTemplateViewController ,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    var Menuview:MenuView?  = nil
    var siftViewModel       = SiftParmterViewModel()
    var viewModel           = ConferenceViewModel()
    var ChannelID           = 0
    var PageIndex: Int      = 1
    var PageSize:  Int      = 10
    var Title_Name          = ""
    var SalesPriorityEnum   = 1
    var ComprehensiveSortingEnum = 1
    //var isSearch: Bool      = false//是否为搜索，用来重置PageIndex，调不同接口
    var searchText: String? = ""
    let reuseIdentifier = "ConferenceCell"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#CCCCCC"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        //基控制器
        self.InitCongifCollection(collectionView, nil)
        self.collectionView.frame = CGRect.init(x: 0, y: 94, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 94)
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
        viewModel.GetChannelsMeetingList(SearchTitle:searchText!,ScreenTitle:Title_Name, SalesPriorityEnum: SalesPriorityEnum, ComprehensiveSortingEnum: ComprehensiveSortingEnum, PageIndex: PageIndex, PageSize: PageSize) { (result, NoMore, NoData) in
            if  result == true {
                //没有数据
                if NoData == true{
                    self.RefreshRequest(isLoading: false,isHiddenFooter: true)
                    return
                }
                //没有更多数据
                if(NoMore==true){
                    self.footer.endRefreshingWithNoMoreData()
                    self.RefreshRequest(isLoading: false, isHiddenFooter: false)
                }//正常返回数据
                else{
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
    // MARK:    筛选栏
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
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索会议室")
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
            print("结束了")
        }
    }
    //重设参数
    func remexParmeter(tag:Bool,searchText:String) -> Void {
        if tag == true {
            self.PageIndex                  = 1
            self.Title_Name                 = ""
            self.SalesPriorityEnum          = 1
            self.ComprehensiveSortingEnum   = 1
            self.searchText                 = searchText
            self.viewModel.ListData.removeAll()
            self.numberOfRowsInSection      = self.viewModel.ListData.count
            self.RefreshRequest(isLoading: true, isHiddenFooter: true,isLoadError: false)
            self.GetHtpsData()
        }
        else{
            self.viewModel.ListData.removeAll()
            self.numberOfRowsInSection = self.viewModel.ListData.count
            self.PageIndex                  = 1
            self.searchText = searchText
            self.RefreshRequest(isLoading: true, isHiddenFooter: true,isLoadError: false)
            self.GetHtpsData()
        }
    }

    func GetAdress() {
        print("当前地址")
    }
    // MARK: UILayoutDelegate,iOS 10之后需要在代理方法里实现
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    // MARK: collectionViewDelegate
    // size大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let showrowsitem:CGFloat=2  //竖屏显示的数目 （暂时未做横屏手机item  间距直接也存在点差异 ipad 没事 iPhone需要修改
        return CGSize(width: (self.view.bounds.size.width)/showrowsitem-8.0, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 5)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ConferenceCell
        if self.viewModel.ListData.count > 0 {
            cell.InitConfig(self.viewModel.ListData[indexPath.row])
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击进入详情页");
        let vc = CommonFunction.ViewControllerWithStoryboardName("ConferenceDetail", Identifier: "ConferenceDetail") as! ConferenceDetail
        self.navigationController?.show(vc, sender: self  )
    }

}
