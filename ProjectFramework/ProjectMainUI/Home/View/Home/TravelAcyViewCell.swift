//
//  TravelAcyViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcyViewCell: UITableViewCell {

    @IBOutlet weak var Img1: UIImageView!
    @IBOutlet weak var Img2: UIImageView!
    
    @IBOutlet weak var Title1: UILabel!
    @IBOutlet weak var Title2: UILabel!
    
    @IBOutlet weak var Money1: UILabel!
    @IBOutlet weak var Money2: UILabel!
    
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    
    weak var delegate:UIViewController?=nil
    
    var TravelAgency=[TravelAgencyModel]()
    
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
        for  i in  0..<TravelAgency.count {
            if(i==0){
                Img1.ImageLoad(PostUrl: HttpsUrlImage+TravelAgency[i].CoverPhoto)
                Title1.text=TravelAgency[i].TravelAgencyName
                Score1.isHidden=false
                Score1.text=TravelAgency[i].Score.format(".1")
                Money1.text="￥"+TravelAgency[i].Score.format(".0")+"起"
            }
            if(i==1){
                Img2.ImageLoad(PostUrl: HttpsUrlImage+TravelAgency[i].CoverPhoto)
                Title2.text=TravelAgency[i].TravelAgencyName
                Score2.isHidden=false
                Score2.text=TravelAgency[i].Score.format(".1")
                Money2.text="￥"+TravelAgency[i].Score.format(".0")+"起"
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
