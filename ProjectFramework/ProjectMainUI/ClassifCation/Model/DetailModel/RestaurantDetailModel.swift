//
//  RestaurantDetailModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/5.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class RestaurantDetailModel: NSObject {
    
    var RestaurantID=0
    var RestaurantName=""
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
    var DescribeName:[DescribeName_List]?
    var Panorama360:ClassPanorama360List?//餐厅全景
    var RestaurantProduct:[RestaurantProduct_List]?
    var CommentMes:[CommentMeModel]?//用户评论（公共）
    var ImageList:[Image_List]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["DescribeName":DescribeName_List.self,"Panorama360":ClassPanorama360List.self,"RestaurantProduct":RestaurantProduct_List.self,"CommentMes":CommentMeModel.self,"ImageList":Image_List.self]
    }
}
//--------------------------------餐厅产品--------------------------------

class RestaurantProduct_List: NSObject {
    
    var RestaurantProductID=0
    var RestaurantID=0
    var Title=""
    var CoverPhoto=""
    var DefaultPrice=0
    var OriginalPrice=0
    var Number=""
    var Reservation=""
    var AdditionalServices=""
    var Description=""
    var Menu:[Menu_List]?
    var ImageList:[Image_List]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["Menu":Menu_List.self,"ImageList":Image_List.self]
    }

    
}
/********************  餐厅产品套餐  ********************/
class Menu_List: NSObject {
    var Name=""
    var Price=0
    var Specifications=""
}
