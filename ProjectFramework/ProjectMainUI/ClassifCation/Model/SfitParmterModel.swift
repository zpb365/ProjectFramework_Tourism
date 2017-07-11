//
//  SfitParmterModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/25.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SfitParmterModel: NSObject {
    var ComprehensiveSorting:[ComprehensiveSortingEnumList_Item]?
    var SalesPriority:[SalesPriorityEnumList_Item]?
    var Screening:[TitleList_Item]?
    var Classing:[Classing_Item]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["ComprehensiveSorting":ComprehensiveSortingEnumList_Item.self,"SalesPriority":SalesPriorityEnumList_Item.self,"Screening":TitleList_Item.self,"Classing":Classing_Item.self]
    }
}
//综合排序
class ComprehensiveSortingEnumList_Item: NSObject {
    var ComperhensiveSortingName=""
    var ComprehensiveSortingEnum=0
}
//销量优先
class SalesPriorityEnumList_Item: NSObject {
    var ComperhensiveSortingName=""
    var SalesPriorityEnum=0
}
//筛选Title
class TitleList_Item: NSObject {
    var Screening=""
    var ScreeningItem:[TitleList_SubItem]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["ScreeningItem":TitleList_SubItem.self]
    }
}
//筛选子Title
class TitleList_SubItem: NSObject {
    var ID=0
    var Title=""
}
//分类
class Classing_Item: NSObject {
    var Screening = ""
    var ScreeningItem:[ScreeningList_Item]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["ScreeningItem":ScreeningList_Item.self]
    }
}
//分类下的子类
class ScreeningList_Item: NSObject {
    var ID = 0
    var Title = ""
}
