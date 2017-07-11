//
//  VisualViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class VisualViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Img1: UIImageView!

    @IBOutlet weak var Img2: UIImageView!
    
    @IBOutlet weak var Img3: UIImageView!
    
    weak var delegate:UIViewController?=nil
    
    
    var BeautifulPictureList=[ClassBeautifulPictureList]()
    var Panorama360List=[ClassPanorama360List]()
    var VRVideoClassList=[ClassVRVideoClassList_Item]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {

        Img2.image=UIImage(named: "")
        Img3.image=UIImage(named: "")
        Img1.isUserInteractionEnabled=true
        Img2.isUserInteractionEnabled=true
        Img3.isUserInteractionEnabled=true
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        tap1.ExpTagInt = 0
        tap2.ExpTagInt = 1
        tap3.ExpTagInt = 2
        for  i in  0..<BeautifulPictureList.count {
            if(i==0){
                Img1.ImageLoad(PostUrl: HttpsUrlImage+BeautifulPictureList[i].CoverPhoto)
                Img1.addGestureRecognizer(tap1)
            }
            if(i==1){
                Img2.ImageLoad(PostUrl: HttpsUrlImage+BeautifulPictureList[i].CoverPhoto)
                Img2.addGestureRecognizer(tap2)
            }
            if(i==2){
                Img3.ImageLoad(PostUrl: HttpsUrlImage+BeautifulPictureList[i].CoverPhoto)
                Img3.addGestureRecognizer(tap3)
            }
            
        }
        
        for  i in 0..<Panorama360List.count {
            if(i==0){
                Img1.ImageLoad(PostUrl: HttpsUrlImage+Panorama360List[i].CoverPhoto)
                Img1.addGestureRecognizer(tap1)
            }
            if(i==1){
                Img2.ImageLoad(PostUrl: HttpsUrlImage+Panorama360List[i].CoverPhoto)
                Img2.addGestureRecognizer(tap2)
            }
            if(i==2){
                Img3.ImageLoad(PostUrl: HttpsUrlImage+Panorama360List[i].CoverPhoto)
                Img3.addGestureRecognizer(tap3)
            }
        }
        
        for  i in 0..<VRVideoClassList.count {
            if(i==0){
                Img1.ImageLoad(PostUrl: HttpsUrlImage+VRVideoClassList[i].CoverPhoto)
                Img1.addGestureRecognizer(tap1)
            }
            if(i==1){
                Img2.ImageLoad(PostUrl: HttpsUrlImage+VRVideoClassList[i].CoverPhoto)
                Img2.addGestureRecognizer(tap2)
            }
            if(i==2){
                Img3.ImageLoad(PostUrl: HttpsUrlImage+VRVideoClassList[i].CoverPhoto)
                Img3.addGestureRecognizer(tap3)
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tapClick(tap:UITapGestureRecognizer) -> Void {
        if BeautifulPictureList.count > 0 {
            let vc = CommonFunction.ViewControllerWithStoryboardName("BeautyPhotoAlbum", Identifier: "BeautyPhotoAlbum") as! BeautyPhotoAlbum
            vc.dataArray = BeautifulPictureList[tap.ExpTagInt].List!
            delegate?.navigationController?.show(vc, sender: self  )

        }
        if Panorama360List.count > 0 {
            let vc = Public360ViewController()
            vc.url = HttpsPanorama360+Panorama360List[tap.ExpTagInt].Panorama360ID.description
            delegate?.present(vc, animated: true, completion: nil)
        }
        if VRVideoClassList.count > 0 {
            let vc = Public360ViewController()
            vc.url = HttpsVR+VRVideoClassList[tap.ExpTagInt].VideoID.description
            delegate?.present(vc, animated: true, completion: nil)

        }
    }
}
