//
//  SpecialtyViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SpecialtyViewCell: UITableViewCell {

    @IBOutlet weak var Img1: UIImageView!
    @IBOutlet weak var Img2: UIImageView!
    
    @IBOutlet weak var Title1: UILabel!
    @IBOutlet weak var Title2: UILabel!
    
    @IBOutlet weak var Money1: UILabel!
    @IBOutlet weak var Money2: UILabel!
    
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    
    weak var delegate:UIViewController?=nil
    
    var Specialities=[SpecialitiesModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {
        Score1.isHidden=true
        Score2.isHidden=true
        Img1.image=UIImage(named: "")
        Img2.image=UIImage(named: "")
        Title1.text=""
        Title2.text=""
        Score1.text=""
        Score2.text=""
        Money1.text=""
        Money2.text=""
        for  i in  0..<Specialities.count {
            if(i==0){
                Img1.ImageLoad(PostUrl: HttpsUrlImage+Specialities[i].CoverPhoto)
                Title1.text=Specialities[i].SpecialitiesName
                Score1.isHidden=false
                Score1.text=Specialities[i].Score.format(".1")
                Money1.text="￥"+Specialities[i].lowestPrice.format(".0")+"起"
                Img1.gestureRecognizers?.removeAll()
                let TapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
                Img1.isUserInteractionEnabled=true
                Img1.addGestureRecognizer(TapGestureRecognizer)
                TapGestureRecognizer.ExpTagInt=Specialities[i].SpecialitiesID
            }
            if(i==1){
                Img2.ImageLoad(PostUrl: HttpsUrlImage+Specialities[i].CoverPhoto)
                Title2.text=Specialities[i].SpecialitiesName
                Score2.isHidden=false
                Score2.text=Specialities[i].Score.format(".1")
                Money2.text="￥"+Specialities[i].lowestPrice.format(".0")+"起"
                Img2.gestureRecognizers?.removeAll()
                let TapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
                Img2.isUserInteractionEnabled=true
                Img2.addGestureRecognizer(TapGestureRecognizer)
                TapGestureRecognizer.ExpTagInt=Specialities[i].SpecialitiesID
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func handleTapGesture(sender: UITapGestureRecognizer){
        let vc = CommonFunction.ViewControllerWithStoryboardName("SpecialtyDetail", Identifier: "SpecialtyDetail") as! SpecialtyDetail
        vc.SpecialitiesID = sender.ExpTagInt
        vc.ChannelID = 6
        delegate?.navigationController?.show(vc, sender: self  )
    }
}
