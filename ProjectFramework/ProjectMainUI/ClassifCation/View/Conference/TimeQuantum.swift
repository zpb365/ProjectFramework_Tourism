//
//  TimeQuantum.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/29.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TimeQuantum: UIView {

    @IBOutlet weak var timeChoose: UIView!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var dateButton: UIButton!

    
    override func layoutSubviews() {
        timeChoose.layer.cornerRadius = 4
        timeChoose.layer.borderColor = UIColor.lightGray.cgColor
        timeChoose.layer.borderWidth = 0.6
    }
}
