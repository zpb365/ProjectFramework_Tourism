//
//  ClassifCationCell.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit


class ClassifCationCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var textLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setCell(iamge: String , text: String) -> Void {
        mainImageView.image = UIImage.init(named: iamge)
        textLable.text = text
    }
    
   
}
