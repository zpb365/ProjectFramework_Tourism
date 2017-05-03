//
//  ScenicSpotCollectionCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotCollectionCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    func setData(_ image:String , isHiden:Bool , centerText:String) -> Void {
        icon.isHidden = isHiden
        lable.isHidden = isHiden
        icon.image = UIImage.init(named: image)
        lable.text = centerText
    }
//    enum Modeltepy{
//        case BeautyImage//美图
//        case PanoramaImage//全景
//        case VRVideo//VR
//        case Attractions//景点
//    }

    func setcell(_ cell:Any , _ type:Modeltepy) -> Void {
        switch type {
        case .PanoramaImage:
            let model = cell as! ClassPanorama360List
            mainImageView.ImageLoad(PostUrl: HttpsUrlImage + model.CoverPhoto)
            titleLable.text = model.Title
            break
        case .VRVideo:
            let model = cell as! ClassVRVideoClassList
            mainImageView.ImageLoad(PostUrl: HttpsUrlImage + model.CoverPhoto)
            titleLable.text = model.VideoName
            break
        case .BeautyImage:
            let model = cell as! ClassBeautifulPictureList
            mainImageView.ImageLoad(PostUrl: HttpsUrlImage + model.CoverPhoto)
            titleLable.text = model.AlbumName
            break
        case .Attractions:
            let model = cell as! ScenicAttractionsList_Item
            mainImageView.ImageLoad(PostUrl: HttpsUrlImage + model.CoverPhoto)
            titleLable.text = model.AttractionsName
            break
        default: break
            
        }
    }
}
