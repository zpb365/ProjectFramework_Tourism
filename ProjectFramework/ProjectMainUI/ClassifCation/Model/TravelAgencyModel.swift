//
//  TravelAgencyModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

//旅行社实体
class TravelAgencyModel: NSObject {
    var TravelAgencyID=0
    var TravelAgencyName=""
    var CoverPhoto=""
    var lowestPrice=0.0
    var CommentsCount=0
    var Score=0.0
    var Lng=""
    var Lat=""
    var List:[TravelAgencyModel_Item]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["List":TravelAgencyModel_Item.self ]
    }
}

class TravelAgencyModel_Item: NSObject {
    var Title=""
    var CoverPhoto=""
}
