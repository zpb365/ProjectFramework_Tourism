//
//  GuideBook.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GuideBook: CustomTemplateViewController ,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel           = GuideViewModel()
    var ChannelID           = 0
    var PageIndex: Int      = 1
    var PageSize:  Int      = 10
    var searchText: String? = ""
    var isSearch:   Bool    = false
    let reuseIdentifier     = "GuideBookCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        //基控制器
        self.InitCongifCollection(collectionView, nil)
        self.collectionView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight , width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight )
        self.GetHtpsData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#009689"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    //MARK: Refresh
    override func footerRefresh() {
        PageIndex = PageIndex + 1
        if isSearch == true {
            self.getSearchData()
        }else{
            self.GetHtpsData()
        }
        self.footer.endRefreshing()
    }
    override func headerRefresh() {
        self.footer.resetNoMoreData()
        self.remexParmeter(tag: false, searchText: "")
        self.header.endRefreshing()
    }
    override func Error_Click() {
        self.remexParmeter(tag: false, searchText: "")
    }
    //MARK: 获取数据
    func GetHtpsData() {
        viewModel.GetChannelsCiceroneList(PageIndex: PageIndex, PageSize: PageSize) { (result, NoMore, NoData) in
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
    //MARK: 搜索数据
    func getSearchData() -> Void {
        viewModel.GetChannelsCiceroneList(ChannelID: self.ChannelID, Title: searchText!, PageIndex: PageIndex, PageSize: PageSize) { (result, NoMore, NoData) in
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
            print("搜索出数组个数\(self.viewModel.ListData.count)")

        }
    }
    // MARK: 设置导航栏
    func setNavbar(){
        
        let CustomNavItem = self.navigationItem
        
        CustomNavItem.titleView = UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "搜索导游")
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
    //MARK: PYSearchViewControllerDelegate 搜索时调用
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWithsearchBar searchBar: UISearchBar!, searchText: String!) {
        searchViewController.dismiss(animated: false) {
            self.remexParmeter(tag: true,searchText: searchText)
            print("结束了")
        }
    }
    //MARK: 重设参数
    func remexParmeter(tag:Bool,searchText:String) -> Void {
        self.PageIndex                  = 1
        self.viewModel.ListData.removeAll()
        self.numberOfRowsInSection      = self.viewModel.ListData.count
        self.searchText            = searchText
        self.isSearch                   = tag
        if tag == true {
            self.RefreshRequest(isLoading: true, isHiddenFooter: true,isLoadError: false)
            self.getSearchData()
        }
        else{
            self.RefreshRequest(isLoading: true, isHiddenFooter: true,isLoadError: false)
            self.GetHtpsData()
        }
    }
    // MARK: UILayoutDelegate,iOS 10之后需要在代理方法里实现
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    // MARK: collectionViewDelegate
    // size大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let showrowsitem:CGFloat=2  //竖屏显示的数目 （暂时未做横屏手机item  间距直接也存在点差异 ipad 没事 iPhone需要修改
        return CGSize(width: (self.view.bounds.size.width)/showrowsitem-12.0, height: 190)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 5)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GuideBookCell
        cell.InitConfig(viewModel.ListData[indexPath.row])
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc =   CommonFunction.ViewControllerWithStoryboardName("GuideBookDetails", Identifier: "GuideBookDetails") as! GuideBookDetailsViewController
        vc.CiceroneID=viewModel.ListData[indexPath.row].CiceroneID
        self.navigationController?.show(vc, sender: self)
    }

}
