//
//  ScenicViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicViewCell: UITableViewCell {

    @IBOutlet weak var Img1: UIImageView!
    
    @IBOutlet weak var Img2: UIImageView!
    
    @IBOutlet weak var Img3: UIImageView!
    
    @IBOutlet weak var text1: UILabel!
    
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var text3: UILabel!
    
    weak var delegate:UIViewController?=nil
    
    var Scenic=[ScenicModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) { 
        Img1.image=UIImage(named: "")
        Img2.image=UIImage(named: "")
        Img3.image=UIImage(named: "")
        text1.text=""
        text2.text=""
        text3.text=""
        Img1.isUserInteractionEnabled=true
        Img2.isUserInteractionEnabled=true
        Img3.isUserInteractionEnabled=true
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        tap1.ExpTagInt = 0
        tap2.ExpTagInt = 1
        tap3.ExpTagInt = 2
        for  i in  0..<Scenic.count {
            if(i==0){Img1.ImageLoad(
                PostUrl: HttpsUrlImage+Scenic[i].CoverPhoto);text1.text=Scenic[i].ScenicName
                Img1.addGestureRecognizer(tap1)
            }
            if(i==1){
                Img2.ImageLoad(PostUrl: HttpsUrlImage+Scenic[i].CoverPhoto);text2.text=Scenic[i].ScenicName
                Img2.addGestureRecognizer(tap2)
            }
            if(i==2){
                Img3.ImageLoad(PostUrl: HttpsUrlImage+Scenic[i].CoverPhoto);text3.text=Scenic[i].ScenicName
                Img3.addGestureRecognizer(tap3)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tapClick(tap:UITapGestureRecognizer) -> Void {
        if Scenic.count > 0 {
            let vc = CommonFunction.ViewControllerWithStoryboardName("ScenicSpotMain", Identifier: "ScenicSpotMain") as! ScenicSpotMain
            vc.ScenicID = Scenic[tap.ExpTagInt].ScenicID
            delegate?.navigationController?.show(vc, sender: self  )
        }
    }
}
