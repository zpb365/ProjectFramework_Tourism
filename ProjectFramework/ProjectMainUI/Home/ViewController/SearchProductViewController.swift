//
//  Shopping.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SearchProductViewController: CustomTemplateViewController ,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var colletionView: UICollectionView!
    let identFier = "SearchListCell"
    var viewModel = SearchProductViewModel()
    var SearchTitle=""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="搜索列表"
        self.GetHttpData()
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func Error_Click() {
        self.GetHttpData()
    }
    func GetHttpData() -> Void {
        viewModel.GetHomeSearchRecordInfo(SearchTitle: SearchTitle) { (result) in
            if result == true{
                
                self.numberOfRowsInSection = self.viewModel.ListData.count
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                print(self.viewModel.ListData.count)
            }else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    
    func initUI() -> Void {
        self.colletionView.frame = CGRect.init(x: 0, y: 64, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 64)
        self.InitCongifCollection(colletionView, nil)        
        self.numberOfSections = 1
        self.header.isHidden = true
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let showrowsitem:CGFloat=2  //竖屏显示的数目 （暂时未做横屏手机item  间距直接也存在点差异 ipad 没事 iPhone需要修改
        return CGSize(width: (self.view.bounds.size.width)/showrowsitem-8.0, height:  (self.view.bounds.size.width)/showrowsitem-8.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 5)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identFier, for: indexPath) as! SearchListCell
        cell.InitConfig(viewModel.ListData[indexPath.row] as Any)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.ListData[indexPath.row]._channelsid {
        case 1:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotMain", Identifier: "ScenicSpotMain") as! ScenicSpotMain
            vc.ScenicID = self.viewModel.ListData[indexPath.row]._channelslistid
            self.navigationController?.show(vc, sender: self  )
            break
        case 2:
            let vc = CommonFunction.ViewControllerWithStoryboardName("HotelDetail", Identifier: "HotelDetail") as! HotelDetail
            vc.HotelID = viewModel.ListData[indexPath.row]._channelslistid
            self.navigationController?.show(vc, sender: self  )
            break
        case 3:
            let vc = CommonFunction.ViewControllerWithStoryboardName("RestaurantDetail", Identifier: "RestaurantDetail") as! RestaurantDetail
            vc.RestaurantID = viewModel.ListData[indexPath.row]._channelslistid
            vc.ChannelID = viewModel.ListData[indexPath.row]._channelsid
            self.navigationController?.show(vc, sender: self  )
            break
        case 4:
            let vc = CommonFunction.ViewControllerWithStoryboardName("TravelAcyDetail", Identifier: "TravelAcyDetail") as! TravelAcyDetail
            vc.TravelAgencyID = viewModel.ListData[indexPath.row]._channelslistid
            vc.ChannelID = viewModel.ListData[indexPath.row]._channelsid
            self.navigationController?.show(vc, sender: self)
            break
        case 5:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ConferenceDetail", Identifier: "ConferenceDetail") as! ConferenceDetail
            vc.MeetingID = viewModel.ListData[indexPath.row]._channelslistid
            vc.ChannelID = viewModel.ListData[indexPath.row]._channelsid
            self.navigationController?.show(vc, sender: self  )
            break
        case 6:
            let vc = CommonFunction.ViewControllerWithStoryboardName("SpecialtyDetail", Identifier: "SpecialtyDetail") as! SpecialtyDetail
            vc.SpecialitiesID = viewModel.ListData[indexPath.row]._channelslistid
            vc.ChannelID = viewModel.ListData[indexPath.row]._channelsid
            self.navigationController?.show(vc, sender: self  )
            break
        case 11:
            let vc =   CommonFunction.ViewControllerWithStoryboardName("GuideBookDetails", Identifier: "GuideBookDetails") as! GuideBookDetailsViewController
            vc.CiceroneID=viewModel.ListData[indexPath.row]._channelslistid
            self.navigationController?.show(vc, sender: self)
            break
        default:
            break
        }
    }

}
