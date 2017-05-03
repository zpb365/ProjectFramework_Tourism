//
//  ScenicSpotMainCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

enum Modeltepy{
    case BeautyImage//美图
    case PanoramaImage//全景
    case VRVideo//VR
    case Attractions//景点
}

class ScenicSpotMainCell: UITableViewCell {

//    typealias CallbackValue=(_ type:Modeltepy ,_ model:Any)->Void //类似于OC中的typedef
//    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
//    func  FuncCallbackValue(type:CallbackValue?){
//        myCallbackValue = type //返回值
//    }
    
    
    
    @IBOutlet weak var mainImageView1: UIImageView!
    @IBOutlet weak var mainImageView2: UIImageView!
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var titleLable2: UILabel!
    @IBOutlet weak var titleLable1: UILabel!
    @IBOutlet weak var bottomView: UILabel!
    
    weak var controller:ScenicSpotHome?=nil
    var flag = 0
    var model1: Any?=nil
    var model2: Any?=nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //把index为奇数隐藏掉
        mainImageView2.isHidden = true
        titleLable2.isHidden = true
        bottomView.isHidden = true
        icon2.isHidden = true
        lable2.isHidden = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }

    func setData(_ image:String , isHiden:Bool , centerText:String) -> Void {
        icon1.isHidden = isHiden
        icon2.isHidden = isHiden
        lable1.isHidden = isHiden
        lable2.isHidden = isHiden
        icon1.image = UIImage.init(named: image)
        icon2.image = UIImage.init(named: image)
        lable1.text = centerText
        lable2.text = centerText
    }
    func setcell(model1:Any,model2:Any,model2isNull:Bool,type:Modeltepy) -> Void {
        //打开用户使能
        mainImageView1.isUserInteractionEnabled = true
        mainImageView2.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(pushTap))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(pushTap))
        
        
        if model2isNull == true{
            //把index为奇数隐藏开
            mainImageView2.isHidden = true
            titleLable2.isHidden = true
            bottomView.isHidden = true
            icon2.isHidden = true
            lable2.isHidden = true
            mainImageView1.addGestureRecognizer(tap1)
            tap1.ExpTagInt=1
            self.model1 = model1
            
        }else{
            //把index为奇数隐藏关闭
            mainImageView2.isHidden = false
            titleLable2.isHidden = false
            bottomView.isHidden = false
            icon2.isHidden = false
            lable2.isHidden = false
            mainImageView1.addGestureRecognizer(tap1)
            mainImageView2.addGestureRecognizer(tap2)
            tap1.ExpTagInt=1
            tap2.ExpTagInt=2
            self.model1 = model1
            self.model2 = model2
        }
        
        switch type {
        case .PanoramaImage:
            self.flag = 1
            if model2isNull == true {
                let item = model1 as! ClassPanorama360List
                mainImageView1.ImageLoad(PostUrl: HttpsUrlImage + item.CoverPhoto)
                titleLable1.text = item.Title
                
            }
            else{
                let item1 = model1 as! ClassPanorama360List
                mainImageView1.ImageLoad(PostUrl: HttpsUrlImage + item1.CoverPhoto)
                titleLable1.text = item1.Title
                
                let item2 = model1 as! ClassPanorama360List
                mainImageView2.ImageLoad(PostUrl: HttpsUrlImage + item2.CoverPhoto)
                titleLable2.text = item2.Title
            }
            break
        case .Attractions:
            self.flag = 2
            if model2isNull == true {
                let item = model1 as! ScenicAttractionsList_Item
                mainImageView1.ImageLoad(PostUrl: HttpsUrlImage + item.CoverPhoto)
                titleLable1.text = item.AttractionsName
            }
            else{
                let item1 = model1 as! ScenicAttractionsList_Item
                mainImageView1.ImageLoad(PostUrl: HttpsUrlImage + item1.CoverPhoto)
                titleLable1.text = item1.AttractionsName
                
                let item2 = model1 as! ScenicAttractionsList_Item
                mainImageView2.ImageLoad(PostUrl: HttpsUrlImage + item2.CoverPhoto)
                titleLable2.text = item2.AttractionsName
            }
            break
        case .BeautyImage:
            self.flag = 3
            if model2isNull == true {
                let item = model1 as! ClassBeautifulPictureList
                mainImageView1.ImageLoad(PostUrl: HttpsUrlImage + item.CoverPhoto)
                titleLable1.text = item.AlbumName
            }
            else{
                let item1 = model1 as! ClassBeautifulPictureList
                mainImageView1.ImageLoad(PostUrl: HttpsUrlImage + item1.CoverPhoto)
                titleLable1.text = item1.AlbumName
                
                let item2 = model1 as! ClassBeautifulPictureList
                mainImageView2.ImageLoad(PostUrl: HttpsUrlImage + item2.CoverPhoto)
                titleLable2.text = item2.AlbumName
            }
            break
        case .VRVideo:
            self.flag = 4
            if model2isNull == true {
                let item = model1 as! ClassVRVideoClassList
                mainImageView1.ImageLoad(PostUrl: HttpsUrlImage + item.CoverPhoto)
                titleLable1.text = item.VideoName
            }
            else{
                let item1 = model1 as! ClassVRVideoClassList
                mainImageView1.ImageLoad(PostUrl: HttpsUrlImage + item1.CoverPhoto)
                titleLable1.text = item1.VideoName
                
                let item2 = model1 as! ClassVRVideoClassList
                mainImageView2.ImageLoad(PostUrl: HttpsUrlImage + item2.CoverPhoto)
                titleLable2.text = item2.VideoName
            }
            break
        default:
            
            break
        }
    }
    //跳转
    func pushTap(_ tap:UITapGestureRecognizer) -> Void {
//        print(tap.ExpTagInt)
        //全景
        if self.flag == 1 {
            var item: ClassPanorama360List!=nil
            if tap.ExpTagInt == 1 {
                item = (self.model1 as? ClassPanorama360List)!
            }
            if tap.ExpTagInt == 2 {
                item = (self.model2 as? ClassPanorama360List)!
            }
            print("跳转到全景图")
            
        }
        if self.flag == 2 {
            var item: ScenicAttractionsList_Item?=nil
            if tap.ExpTagInt == 1 {
                item = (self.model1 as? ScenicAttractionsList_Item)!
            }
            if tap.ExpTagInt == 2 {
                item = (self.model2 as? ScenicAttractionsList_Item)!
            }
            print("跳转到景点")
        }
        if self.flag == 3 {
            var item: ClassBeautifulPictureList?=nil
            if tap.ExpTagInt == 1 {
                item = (self.model1 as? ClassBeautifulPictureList)!
            }
            if tap.ExpTagInt == 2 {
                item = (self.model2 as? ClassBeautifulPictureList)!
            }
            let vc = CommonFunction.ViewControllerWithStoryboardName("BeautyPhotoAlbum", Identifier: "BeautyPhotoAlbum") as! BeautyPhotoAlbum
            vc.dataArray = (item?.List)!
            self.controller?.navigationController?.show(vc, sender: self  )
            print("跳转到美图")
        }
        if self.flag == 4 {
            var item: ClassVRVideoClassList?=nil
            if tap.ExpTagInt == 1 {
                item = (self.model1 as? ClassVRVideoClassList)!
            }
            if tap.ExpTagInt == 2 {
                item = (self.model2 as? ClassVRVideoClassList)!
            }
            print("跳转到VR视频")
        }
    }
}
