//
//  ScenicSpotImage.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotImage: CustomTemplateViewController ,UICollectionViewDelegateFlowLayout,ScrollEnabledDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "ScenicSpotCollectionCell"
    var dataArray:[ClassBeautifulPictureList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print((dataArray?.count)!)
        self.initUI()
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
    }
    
    func initUI() -> Void {
        //基控制器
        self.InitCongifCollection(collectionView, nil)
        self.collectionView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 64 - 30)
        self.numberOfSections=1
        self.numberOfRowsInSection=(self.dataArray?.count)!//显示行数
        self.header.isHidden = true
        self.collectionView.isScrollEnabled = false
        self.collectionView.register(UINib(nibName: "ScenicSpotCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(ScenicSpotHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
    }
    // MARK: UILayoutDelegate,iOS 10之后需要在代理方法里实现
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let showrowsitem:CGFloat=2  //竖屏显示的数目 （暂时未做横屏手机item  间距直接也存在点差异 ipad 没事 iPhone需要修改
        
        return CGSize(width: (self.view.bounds.size.width - 15.0)/showrowsitem, height: ((self.view.bounds.size.width - 15.0)/showrowsitem) * 0.8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  CGSize(width: CommonFunction.kScreenWidth, height: 35)
    }
    //不给重复创建的标记
    var isCreate: Bool = false
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)as! ScenicSpotHeaderReusableView
            head.setHeader(text: "美图", color: UIColor().TransferStringToColor("#00ABEE"), isCreate: isCreate)
            isCreate = true
            return head
        }
        else{
            return UICollectionReusableView()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScenicSpotCollectionCell
        cell.setData("", isHiden: true, centerText: "")
        cell.setcell(self.dataArray?[indexPath.row] as Any, .BeautyImage)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("BeautyPhotoAlbum", Identifier: "BeautyPhotoAlbum") as! BeautyPhotoAlbum
        vc.dataArray = (self.dataArray?[indexPath.row].List)!
        self.navigationController?.show(vc, sender: self  )
    }
    //MARK: SlidingDelegate
    func ScrollEnabledCan() {
//        print("实现代理")
        self.collectionView.isScrollEnabled = true
    }
    func ScrollEnabledNo() {
//        print("实现代理")
        self.collectionView.isScrollEnabled = false
    }
    deinit {    //销毁页面
        debugPrint("美图 页面已经销毁")
    }
}
