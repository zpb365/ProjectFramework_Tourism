//
//  HotelDetailModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/3.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

//--------------------------------酒店详情实体--------------------------------
class HotelDetailModel: NSObject {
    var HotelID=0
    var HotelName=""
    var CoverPhoto=""
    var Address=""
    var Phone=""
    var Introduce=""
    var Lng=""
    var Lat=""
    var TrafficGuide=""
    var tab=""
    var Score=""
    var CommentsCount=0
    var BookInformation=""
    var ToDayOrderNumber=""
    var DescribeName:[DescribeName_List]?
    var Panorama360:ClassPanorama360List?//酒店全景
    var HotelProduct:[HotelProduct_List]?
    var ImageList:[Image_List]?
    var CommentMes:[CommentMeModel]?//用户评论（公共）
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["DescribeName":DescribeName_List.self,"Panorama360":ClassPanorama360List.self,"HotelProduct":HotelProduct_List.self,"ImageList":Image_List.self,"CommentMes":CommentMeModel.self]
    }
}
/********************  酒店设施  ********************/
class DescribeName_List: NSObject {
    var DescribeNameID=0
    var Name=""
    var List:[DescribeName_ListItem]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["List":DescribeName_ListItem.self]
    }
}
//酒店设施标题和值实体
class DescribeName_ListItem: NSObject {
    var Title=""
    var Describel=""
}
/********************  酒店商品  ********************/
class HotelProduct_List: NSObject {
    var HotelProductID=0
    var HotelID=0
    var Title=""
    var CoverPhoto=""
    var BedType=""
    var Breakfast=""
    var Network=""
    var Acreage=""
    var Policy=""
    var IsInventory=true
    var Price=0
    var DescribeName:[DescribeName_ListItem]?
    var ImageList:[Image_List]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["DescribeName":DescribeName_ListItem.self,"ImageList":Image_List.self]
    }
}
//酒店图片组
class Image_List: NSObject {
    var PhotoUrl=""
    var PhotoDescribe=""
    var Tab=""
    var CreateTime=""
}
