//
//  GuideDetailModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class GuideDetailModel:NSObject {
    
    var CiceroneID = 0
    var CiceroneName=""
    var Sex=0
    var ServiceArea=""
    var WorkingYears=""
    var CoverPhoto=""
    var Phone=""
    var Language=""
    var CertificateID=""
    var Autograph=""
    var Selfintroduction=""
    var Introduce=""
    var ImageList:[ClassBeautifulPictureList_Item]!
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["ImageList":ClassBeautifulPictureList_Item.self]
    }
    
    
}
