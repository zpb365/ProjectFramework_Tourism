//
//  SpecialtyDetailModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SpecialtyDetailModel: NSObject {
    var SpecialitiesID = 0
    var SpecialitiesName=""
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
    var SpecialitiesProduct:[SpecialitiesProduct_List]?//
    var CommentMes:[CommentMeModel]?//用户评论（公共）
    var ImageList:[Image_List]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["DescribeName":DescribeName_List.self,"SpecialitiesProduct":SpecialitiesProduct_List.self,"ImageList":Image_List.self,"CommentMes":CommentMeModel.self]
    }

}

class SpecialitiesProduct_List: NSObject {
    var SpecialitiesProductID=0
    var SpecialitiesID=0
    var Title=""
    var CoverPhoto=""
    var DefaultPrice=0
    var Introduce=""
    var DefaultInventor=0//库存
    
}
