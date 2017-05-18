//
//  VRVideo.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class VRVideo: CustomTemplateViewController {

    var width: CGFloat!
    var collectionView:UICollectionView!
    let reuseIdentifier = "CustomWaterCell"
    var viewModel = VRVideoViewModel()
    var PageIndex: Int = 1
    var PageSize: Int = 10
    
    override func viewWillDisappear(_ animated: Bool)  {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.GetHtpsData()
    }
    //MARK: Refresh
    override func footerRefresh() {
        
        PageIndex = PageIndex + 1
        self.GetHtpsData()
        self.footer.endRefreshing()
    }
    override func headerRefresh() {
        self.footer.resetNoMoreData()
        PageIndex = 1
        self.GetHtpsData()
        self.header.endRefreshing()
    }
    //MARK: 获取数据
    func GetHtpsData() {
        
        viewModel.GetChannelsVideo(PageIndex: PageIndex, PageSize: PageSize) { (result,NoMore) in
            if  result == true {
                
                if(NoMore==true){
                    self.footer.endRefreshingWithNoMoreData()
                    
                }else{
                    self.numberOfRowsInSection = self.viewModel.ListData.count
                    self.RefreshRequest(isLoading: false, isHiddenFooter: false)
                }
            }
            else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    ///数据请求出错了处理事件
    override func Error_Click() {
        PageIndex = 1
        GetHtpsData()
    }

    func initUI() -> Void {
        width = (view.bounds.size.width - 20)/3
        let layout = WaterCollectionViewLayout()

        
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 94), collectionViewLayout: layout)
        collectionView.register(CustomWaterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor.white
        self.InitCongifCollection(collectionView,  nil)
        self.numberOfSections=1
        view.addSubview(collectionView)

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomWaterCell
        cell.setData("360Panorama", isHiden: false, centerText: "VR")
        cell.setCell(viewModel.ListData[indexPath.row], tepy: .VRVideo)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = Public360ViewController()
        vc.url = HttpsVR+viewModel.ListData[indexPath.row].VideoID.description
        self.present(vc, animated: true, completion: nil)
    }
}
