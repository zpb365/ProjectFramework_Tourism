//
//  TravelAcyDetailModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcyDetailModel: NSObject {
    var TravelAgencyID=0
    var TravelAgencyName=""
    var CoverPhoto=""
    var Address=""
    var Phone=""
    var Introduce=""
    var TourismScope=""
    var Lng=""
    var Lat=""
    var TrafficGuide=""
    var tab=""
    var Score=0.0
    var CommentsCount=0
    var BookInformation=""
    var DescribeName:[DescribeName_List]?
    var TravelAgencyProduct:[TravelAgencyProduct_List]?
    var CommentMes:[CommentMeModel]?//用户评论（公共）
    var ImageList:[Image_List]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["DescribeName":DescribeName_List.self,"TravelAgencyProduct":TravelAgencyProduct_List.self,"CommentMes":CommentMeModel.self,"ImageList":Image_List.self]
    }

}

class TravelAgencyProduct_List: NSObject {
    var TravelAgencyProductID=0
    var TravelAgencyID=0
    var Title=""
    var CoverPhoto=""
    var DefaultPrice=0
    var AdditionalServices=""
    var LineIntroduce=""
    var Nature=0
    var OutLine=""
    var OutPlace=""
    var BookInformation=""
}
