//
//  ScenicDetailModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/27.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
//--------------------------------景区详情实体--------------------------------
class ScenicDetailModel: NSObject {
    var ScenicID=0//景区id
    var ScenicName=""//景区名字
    var Logo=""//景区图片
    var Address=""//地址
    var Lng=""
    var Lat=""
    var Tel=""//电话
    var ScenicContent=""//内容简介
    var BookingNotes=0//内容
    var ScenicDetailsAdv:[ScenicDetailsAdvList_Item]?//轮播图
    var ScenicHome:ScenicHomeItem?//景区首页
    var ScenicNews:ScenicNews_Item?
    var Panorama360:[ClassPanorama360List]?
    var VRVideoClass:[ClassVRVideoClassList]?
    var BeautifulPicture:[ClassBeautifulPictureList]?
    var ScenicAttractions:[ScenicAttractionsList_Item]?
    var ScenicParking:[ScenicParkingList]?
    var ScenicTicket:[ScenicTicketList]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["ScenicDetailsAdv":ScenicDetailsAdvList_Item.self,"ScenicHome":ScenicHomeItem.self,"ScenicNews":ScenicNews_Item.self,"ScenicHome":ScenicHomeItem.self,"Panorama360":ClassPanorama360List.self,"VRVideoClass":ClassVRVideoClassList.self,"BeautifulPicture":ClassBeautifulPictureList.self,"ScenicAttractions":ScenicAttractionsList_Item.self,"ScenicParking":ScenicParkingList.self,"ScenicTicket":ScenicTicketList.self]
    }

}
//--------------------------------景区详情轮播图--------------------------------
class ScenicDetailsAdvList_Item: NSObject {
    var Title=""//标题
    var Img=""//图片
    var LinkUrl=""//网址
}
//--------------------------------景区详情首页--------------------------------
class ScenicHomeItem: NSObject {
    var NewsClass:NewsClassItem?//资讯
    var ScenicAttractions:[ScenicAttractionsList_Item]?//景点
    var Panorama360:[ClassPanorama360List]?
    var VRVideoClass:[ClassVRVideoClassList]?
    var BeautifulPicture:[ClassBeautifulPictureList]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["NewsClass":NewsClassItem.self,"ScenicAttractions":ScenicAttractionsList_Item.self,"Panorama360":ClassPanorama360List.self,"VRVideoClass":ClassVRVideoClassList.self,"BeautifulPicture":ClassBeautifulPictureList.self]
    }
}
/********************  NewsClass  ********************/
class NewsClassItem: NSObject {
    var NewsClassId=0
    var NewsClassName=""
    var ScenicNews:[ScenicNewsList_Item]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["ScenicNews":ScenicNewsList_Item.self]
    }
}
//资讯列表
class ScenicNewsList_Item: NSObject {
    var Title=""
    var Description=""
    var NewsContent=""//资讯列表富文本
    var UpdateTime=""//更新时间
}
/********************  ScenicAttractionsList_Item  ********************/
class ScenicAttractionsList_Item: NSObject {
    var AttractionsName=""//景点名
    var AttractionsDescription=""//景点描述
    var AttractionsContent=""//景点内容
    var CoverPhoto=""//景点图片
    var Lng=""
    var lat=""
}
//--------------------------------景区详情资讯--------------------------------
class ScenicNews_Item: NSObject {
    var News:[NewsClassItem]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["News":NewsClassItem.self]
    }

}
//--------------------------------景区详情停车场--------------------------------
class ScenicParkingList: NSObject {
    var parkingId=0
    var parkingName=""
    var CoverPhoto=""
    var Describe=""
    var parkingContent=""
    var Address=""
    var Number=""
    var Lng=""
    var Lat=""
}
//--------------------------------景区详情购票--------------------------------
class ScenicTicketList: NSObject {
    var ScenicProductID=0
    var Title=""
    var CoverPhoto=""
    var DefaultPrice=0
    var TicketsTypes=0
    var Details=""
    var CreateTime=""
}
