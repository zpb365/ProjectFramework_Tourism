//
//  HomeModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class HomeModel: NSObject {
    var advList:[ClassAdvList]! //轮播
    var NewsList:[ClassNewsList]!   //资讯（智慧头条)
    var HotList:[ClassHotList]!   //热门推荐
    var VisualFeast:ClassVisualFeast!   //视觉盛宴
    var Scenic:[ScenicModel]!   //景区
    var Hotel:[HotelModel]!   //酒店
    var Restaurant:[RestaurantModel]!   //餐厅
    var TravelAgency:[TravelAgencyModel]! //旅行社
    var Meeting:[MeetingModel]!   //会议会展
    var Specialities:[SpecialitiesModel]! //特产
    var Travels:[TravelsModel]! //游记
    
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["advList":ClassAdvList.self,
                "NewsList":ClassNewsList.self,
                "HotList":ClassHotList.self,
                "Scenic":ScenicModel.self,
                "Hotel":HotelModel.self,
                "Restaurant":RestaurantModel.self,
                "TravelAgency":TravelAgencyModel.self,
                "Meeting":MeetingModel.self,
                "Specialities":SpecialitiesModel.self,
                "Travels":TravelsModel.self
                ]
    }
}

//-------轮播实体
class ClassAdvList: NSObject {
    var Title=""
    var Img=""
    var LinkUrl=""
}

//----------资讯实体
class ClassNewsList: NSObject {
    var NewsTypeId=0
    var NewsTypeName=""
    var List:[ClassNewsList_Item]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["List":ClassNewsList_Item.self]
    }
}

class ClassNewsList_Item: NSObject {
    var Title=""
    var Description=""
    var NewsContent=""
    var CreateTime=""
}

//-----------热门推荐实体
class ClassHotList: NSObject {
    var Title=""
    var Img=""
    var LinkUrl=""
}


//----------视觉盛宴实体
class ClassVisualFeast: NSObject {
    var BeautifulPictureList:[ClassBeautifulPictureList]?
    var Panorama360List:[ClassPanorama360List]?
    var VRVideoClassList:[ClassVRVideoClassList]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["BeautifulPictureList":ClassBeautifulPictureList.self,
                "Panorama360List":ClassPanorama360List.self,
                "VRVideoClassList":ClassVRVideoClassList.self]
    }
}















