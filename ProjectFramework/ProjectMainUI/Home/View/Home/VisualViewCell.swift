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
    var VRVideoClassList=[ClassVRVideoClassList]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {
        Img1.image=UIImage(named: "")
        Img2.image=UIImage(named: "")
        Img3.image=UIImage(named: "")
        Img1.isUserInteractionEnabled=true
        for  i in  0..<BeautifulPictureList.count {
            if(i==0){Img1.ImageLoad(PostUrl: HttpsUrlImage+BeautifulPictureList[i].CoverPhoto)}
            if(i==1){Img2.ImageLoad(PostUrl: HttpsUrlImage+BeautifulPictureList[i].CoverPhoto)}
            if(i==2){Img3.ImageLoad(PostUrl: HttpsUrlImage+BeautifulPictureList[i].CoverPhoto)}
        }
        
        for  i in 0..<Panorama360List.count {
            if(i==0){Img1.ImageLoad(PostUrl: HttpsUrlImage+Panorama360List[i].CoverPhoto)}
            if(i==1){Img2.ImageLoad(PostUrl: HttpsUrlImage+Panorama360List[i].CoverPhoto)}
            if(i==2){Img3.ImageLoad(PostUrl: HttpsUrlImage+Panorama360List[i].CoverPhoto)}
        }
        
        for  i in 0..<VRVideoClassList.count {
            if(i==0){Img1.ImageLoad(PostUrl: HttpsUrlImage+VRVideoClassList[i].CoverPhoto)}
            if(i==1){Img2.ImageLoad(PostUrl: HttpsUrlImage+VRVideoClassList[i].CoverPhoto)}
            if(i==2){Img3.ImageLoad(PostUrl: HttpsUrlImage+VRVideoClassList[i].CoverPhoto)}
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
