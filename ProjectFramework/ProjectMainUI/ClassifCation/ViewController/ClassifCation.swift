//
//  ClassifCation.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit



class ClassifCation: CustomTemplateViewController ,UICollectionViewDelegateFlowLayout{

    let reuseIdentifier = "ClassifCation"
    @IBOutlet weak var CollectView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var viewModel = ClassifCationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //基控制器
        self.InitCongifCollection(CollectView, nil)
        self.header.isHidden = true
        self.footer.isHidden = true
        CollectView.reloadData()
        self.GetHtpsData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor(), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
    }
    //MARK: getDta
    
    func GetHtpsData() {
        viewModel.GetChannelDta { (result) in
            if  result == true {
                self.numberOfSections = 1
                self.numberOfRowsInSection = self.viewModel.ListData.count
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                
            }else{
                
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    
    // MARK: UILayoutDelegate,iOS 10之后需要在代理方法里实现
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    // MARK: collectionViewDelegate
    // size大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let showrowsitem:CGFloat=3  //竖屏显示的数目 （暂时未做横屏手机item  间距直接也存在点差异 ipad 没事 iPhone需要修改
        
        return CGSize(width: (self.view.bounds.size.width - 20.0)/showrowsitem, height: ((self.view.bounds.size.width - 20.0)/showrowsitem) * 1.318)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ClassifCationCell
        cell.InitConfig(viewModel.ListData[indexPath.row])
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(num: indexPath.row )
    }
    // MARK: 跳转
    func push(num: Int){
        let chanleID = self.viewModel.ListData[num]._channelid
        
        switch chanleID {
            //景区
        case 1:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ScenicSpot", Identifier: "ScenicSpot") as! ScenicSpot
            vc.ChannelID = 1
            self.navigationController?.show(vc, sender: self  )
            break
            //
        case 2:
            let vc = CommonFunction.ViewControllerWithStoryboardName("HotelReserve", Identifier: "HotelReserve") as! HotelReserve
            vc.ChannelID = 2
            self.navigationController?.show(vc, sender: self  )
            break
        case 3:
            let vc = CommonFunction.ViewControllerWithStoryboardName("Restaurant", Identifier: "Restaurant") as! Restaurant
            vc.ChannelID = 3
            self.navigationController?.show(vc, sender: self  )
            break
        case 4:
            let vc = CommonFunction.ViewControllerWithStoryboardName("TravelAcy", Identifier: "TravelAcy") as! TravelAcy
            vc.ChannelID = 4
            self.navigationController?.show(vc, sender: self  )
            break
            
        case 5:
            let vc = CommonFunction.ViewControllerWithStoryboardName("Conference", Identifier: "Conference") as! Conference
            vc.ChannelID = 5
            self.navigationController?.show(vc, sender: self  )
            break
            
        case 11:
            let vc = CommonFunction.ViewControllerWithStoryboardName("GuideBook", Identifier: "GuideBook") as! GuideBook
            vc.ChannelID = 11
            self.navigationController?.show(vc, sender: self  )
            break
            
        case 9:
            let vc = CommonFunction.ViewControllerWithStoryboardName("PolicyNews", Identifier: "PolicyNews") as! PolicyNews
            vc.title = self.viewModel.ListData[num]._channelname
            self.navigationController?.show(vc, sender: self  )
            break
            
        case 6:
            let vc = CommonFunction.ViewControllerWithStoryboardName("Specialty", Identifier: "Specialty") as! Specialty
            vc.ChannelID = 6
            self.navigationController?.show(vc, sender: self  )
            break
        case 10:
            let vc = CommonFunction.ViewControllerWithStoryboardName("VisualFeast", Identifier: "VisualFeast") as! VisualFeast
            vc.title = self.viewModel.ListData[num]._channelname
            self.navigationController?.show(vc, sender: self  )
            break
        default:
            print(num)
            break
        }
    }
    
    //刷新
    override func headerRefresh() {
        header.endRefreshing()
    }
    //数据请求出错了处理事件
    override func Error_Click() {
        GetHtpsData()
    }

}
