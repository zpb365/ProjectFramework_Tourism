//
//  ClassifCation.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit 
                 // CustomTemplateViewController  自定义模板控制器
class ClassifCation: CustomTemplateViewController ,UICollectionViewDelegateFlowLayout{

    let reuseIdentifier = "ClassifCation"
    @IBOutlet weak var CollectView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var imageArray = Array<Any>()
    let textArray = ["政务资讯","视觉盛宴","景区","酒店预订","餐厅餐饮","旅行社","会议","特产购物","导游预订"]
    // collectioniew属性
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //基控制器
        self.InitCongifCollection(CollectView, nil)
        self.numberOfSections=1//显示行数
        // Do any additional setup after loading the view.
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: getDta
    func getData() -> Void {
        for i in 0..<9 {
            let imageString = "Classif\(i).jpg"
            imageArray.append(imageString)
        }
        self.CollectView.reloadData()
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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ClassifCationCell
        cell.setCell(iamge: imageArray[indexPath.row] as! String, text: textArray[indexPath.row])
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击");
        //后接口替换成实体类
        self.push(num: indexPath.row )
    }
    // MARK: 跳转
    func push(num: Int){
        
        switch textArray[num] {
            //景区
        case "1":
            let vc = CommonFunction.ViewControllerWithStoryboardName("ScenicSpot", Identifier: "ScenicSpot") as! ScenicSpot
            self.navigationController?.show(vc, sender: self  )
            break
            //
        case "酒店预订":
            let vc = CommonFunction.ViewControllerWithStoryboardName("HotelReserve", Identifier: "HotelReserve") as! HotelReserve
            self.navigationController?.show(vc, sender: self  )
            break
        case "餐厅餐饮":
            let vc = CommonFunction.ViewControllerWithStoryboardName("Restaurant", Identifier: "Restaurant") as! Restaurant
            self.navigationController?.show(vc, sender: self  )
            break
        case "旅行社":
            let vc = CommonFunction.ViewControllerWithStoryboardName("TravelAcy", Identifier: "TravelAcy") as! TravelAcy
            self.navigationController?.show(vc, sender: self  )
            break
            
        case "会议":
            let vc = CommonFunction.ViewControllerWithStoryboardName("Conference", Identifier: "Conference") as! Conference
            self.navigationController?.show(vc, sender: self  )
            break
            
        case "导游预订":
            let vc = CommonFunction.ViewControllerWithStoryboardName("GuideBook", Identifier: "GuideBook") as! GuideBook
            self.navigationController?.show(vc, sender: self  )
            break
            
        case "政务资讯":
            let vc = CommonFunction.ViewControllerWithStoryboardName("PolicyNews", Identifier: "PolicyNews") as! PolicyNews
            self.navigationController?.show(vc, sender: self  )
            break
            
        case "特产购物":
            let vc = CommonFunction.ViewControllerWithStoryboardName("Specialty", Identifier: "Specialty") as! Specialty
            self.navigationController?.show(vc, sender: self  )
            break
        case "视觉盛宴":
            let vc = CommonFunction.ViewControllerWithStoryboardName("VisualFeast", Identifier: "VisualFeast") as! VisualFeast
            self.navigationController?.show(vc, sender: self  )
//              self.navigationController?.show(aaqaaViewController(),sender: self)
            break
        default:
            print(num)
            break
        }
    }
    
    //刷新
    override func headerRefresh() {
        print("aaaa")
        header.endRefreshing()
    }

}
