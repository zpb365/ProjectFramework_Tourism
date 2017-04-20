//
//  MeetingViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MeetingViewCell: UITableViewCell {

    @IBOutlet weak var Img1: UIImageView!
    @IBOutlet weak var Img2: UIImageView!
    @IBOutlet weak var Img3: UIImageView!
    
    @IBOutlet weak var Title1: UILabel!
    @IBOutlet weak var Title2: UILabel!
    @IBOutlet weak var Title3: UILabel!
    
    @IBOutlet weak var Money1: UILabel!
    @IBOutlet weak var Money2: UILabel!
    @IBOutlet weak var Money3: UILabel!
    
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    @IBOutlet weak var Score3: UILabel!
    
    weak var delegate:UIViewController?=nil
    
    var Meeting=[MeetingModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {
        Score1.isHidden=true
        Score2.isHidden=true
        Score3.isHidden=true
        Img1.image=UIImage(named: "")
        Img2.image=UIImage(named: "")
        Img3.image=UIImage(named: "")
        Title1.text=""
        Title2.text=""
        Title3.text=""
        Score1.text=""
        Score2.text=""
        Score3.text=""
        Money1.text=""
        Money2.text=""
        Money3.text=""
        for  i in  0..<Meeting.count {
            if(i==0){
                Img1.ImageLoad(PostUrl: HttpsUrlImage+Meeting[i].CoverPhoto)
                Title1.text=Meeting[i].MeetingName
                Score1.isHidden=false
                Score1.text=Meeting[i].Score.format(".1")
                Money1.text="￥"+Meeting[i].Score.format(".0")+"起"
            }
            if(i==1){
                Img2.ImageLoad(PostUrl: HttpsUrlImage+Meeting[i].CoverPhoto)
                Title2.text=Meeting[i].MeetingName
                Score2.isHidden=false
                Score2.text=Meeting[i].Score.format(".1")
                Money2.text="￥"+Meeting[i].Score.format(".0")+"起"
            }
            if(i==2){
                Img3.ImageLoad(PostUrl: HttpsUrlImage+Meeting[i].CoverPhoto)
                Title3.text=Meeting[i].MeetingName
                Score3.isHidden=false
                Score3.text=Meeting[i].Score.format(".1")
                Money3.text="￥"+Meeting[i].Score.format(".0")+"起"
            }
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
