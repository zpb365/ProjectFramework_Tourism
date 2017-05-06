//
//  DateSectionView.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/22.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class DateSectionView: UIView {

    @IBOutlet weak var startButon: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var dateCount: UILabel!
    
    var day=0
    
    func setDate(startYear:Int ,startMoon:Int ,startDay:Int,endYear:Int ,endMoon:Int,endDay:Int) -> Int {
        
        //一年结束且开始的情况
        if startMoon == 12 && endMoon == 1 {
            day = 31 - startDay + endDay
        }else{
            //每个月份
            switch startMoon {
            case 1,3,5,7,8,10,12:
                if startMoon == endMoon {
                    day = endDay - startDay
                }else{
                    day = 31 - startDay + endDay
                }
                break
            case 2:
                if startMoon == endMoon {
                    day = endDay - startDay
                }else{
                    //闰年
                    if ((startYear % 4 == 0 && startYear % 100 != 0) || startYear % 400 == 0){
                       day = 29 - startDay + endDay
                    }else{
                       day = 28 - startDay + endDay
                    }
                }
                break
            case 4,6,9,11:
                if startMoon == endMoon {
                    day = endDay - startDay
                }else{
                    day = 30 - startDay + endDay
                }
                break
            default:
                break
            }
        }
        
        startButon.setTitle("\(startMoon)月\(startDay)日", for: .normal)
        endButton.setTitle("\(endMoon)月\(endDay)日", for: .normal)
        dateCount.text = "共\(day)晚"
        return day
    }

}
