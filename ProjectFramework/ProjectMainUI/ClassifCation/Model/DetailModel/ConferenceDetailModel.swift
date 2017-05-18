//
//  ConferenceDetailModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ConferenceDetailModel: NSObject {
    var MeetingID = 0
    var MeetingName=""
    var CoverPhoto=""
    var Address=""
    var Phone=""
    var Introduce=""
    var Lng=""
    var Lat=""
    var TrafficGuide=""
    var tab=""
    var Score=0.0
    var CommentsCount=0
    var BookInformation=""
    var Field1=""
    var Field2=""
    var Field3=""
    var Field4=""
    var DescribeName:[DescribeName_List]?
    var Panorama360:ClassPanorama360List?//全景
    var CommentMes:[CommentMeModel]?//用户评论（公共）
    var ImageList:[Image_List]?
    var MeetingProduct:[MeetingProduct_List]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["DescribeName":DescribeName_List.self,"Panorama360":ClassPanorama360List.self,"MeetingProduct":MeetingProduct_List.self,"ImageList":Image_List.self,"CommentMes":CommentMeModel.self]
    }
}

class MeetingProduct_List: NSObject {
    var MeetingProductID=0
    var MeetingID=0
    var Title=""
    var CoverPhoto=""
    var Acreage=""
    var Capacity=""
    var AdditionalServices=""
    var Price=""
    var IsInventory=true
    var DescribeName:[DescribeName_ListItem]?
    var ImageList:[Image_List]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["DescribeName":DescribeName_ListItem.self,"ImageList":Image_List.self]
    }
}
