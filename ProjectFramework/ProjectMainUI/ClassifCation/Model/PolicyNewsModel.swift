//
//  PolicyNewsModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/21.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class PolicyNewsModel: NSObject {
    var NewsTypeId = 0
    var NewsTypeName = ""
    var News:[PolicyNewsItemModel]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["News":PolicyNewsItemModel.self]
    }
}

class PolicyNewsItemModel:NSObject {
    var NewsId = 0
    var NewsTypeId = 0
    var Title = ""
    var Description = ""
    var NewsContent = ""
    var Views = 0
    var Views_base = 0
    var Author = ""
    var SmallPicture = ""
}
