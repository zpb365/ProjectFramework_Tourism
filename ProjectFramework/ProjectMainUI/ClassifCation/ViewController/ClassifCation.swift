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
    // collectioniew属性
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //基控制器
        self.InitCongifCollection(CollectView, nil) 
        self.numberOfRowsInSection=8//显示的个数
        self.numberOfSections=1//显示行数
        // Do any additional setup after loading the view.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.InitConfig("")
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击");
        //后接口替换成实体类
        self.push(num: indexPath.row )
    }
    // MARK: 跳转
    func push(num: Int){
        
        switch num {
            //景区
        case 0:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ScenicSpot", Identifier: "ScenicSpot") as! ScenicSpot
            self.navigationController?.show(vc, sender: self  )
            break
            //
        case 1:
            let vc = CommonFunction.ViewControllerWithStoryboardName("HotelReserve", Identifier: "HotelReserve") as! HotelReserve
            self.navigationController?.show(vc, sender: self  )
            break
        case 2:
            let vc = CommonFunction.ViewControllerWithStoryboardName("Restaurant", Identifier: "Restaurant") as! Restaurant
            self.navigationController?.show(vc, sender: self  )
            break
        case 3:
            let vc = CommonFunction.ViewControllerWithStoryboardName("TravelAcy", Identifier: "TravelAcy") as! TravelAcy
            self.navigationController?.show(vc, sender: self  )
            break
            
        case 4:
            let vc = CommonFunction.ViewControllerWithStoryboardName("Conference", Identifier: "Conference") as! Conference
            self.navigationController?.show(vc, sender: self  )
            break
            
        case 5:
            let vc = CommonFunction.ViewControllerWithStoryboardName("GuideBook", Identifier: "GuideBook") as! GuideBook
            self.navigationController?.show(vc, sender: self  )
            break
            
        case 6:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ParkingPlace", Identifier: "ParkingPlace") as! ParkingPlace
            self.navigationController?.show(vc, sender: self  )
            break
            
        case 7:
            let vc = CommonFunction.ViewControllerWithStoryboardName("Specialty", Identifier: "Specialty") as! Specialty
            self.navigationController?.show(vc, sender: self  )
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
