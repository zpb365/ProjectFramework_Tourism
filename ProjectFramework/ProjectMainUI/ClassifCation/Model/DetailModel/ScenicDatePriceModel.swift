//
//  ScenicDatePriceModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/28.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class ScenicDatePriceModel: NSObject {
    var Yeas=0
    var Month=0
    var List:[ScenicDatePriceList_Item]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["List":ScenicDatePriceList_Item.self]
    }
}
class ScenicDatePriceList_Item: NSObject {
    var DateTimeSelectedID=0
    var DateTime=""
    var Yeas=0
    var Day=0
    var Price=0
    var Inventory=0
    var IsOrder=0
    var Month=0
}
