//
//  CommentSectionView.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class CommentSectionView: UIView {

    @IBOutlet weak var Satisfaction: UILabel!
    @IBOutlet weak var conmontCount: UILabel!
    
    func setData(scorce:CGFloat , CommentCount:Int) -> Void {
        if scorce != 0 {
            let num = scorce / 5 * 100
            Satisfaction.text = "\(num)%满意"
        }
        conmontCount.text = "共\(CommentCount)人点评"
    }
}
