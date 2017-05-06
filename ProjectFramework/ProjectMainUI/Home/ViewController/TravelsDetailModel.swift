//
//  TravelsDetailModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/3.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class TravelsDetailModel:NSObject  {
    
    var TravelsId=0
    var TravelsTitle=""
    var TravelsNote=""
    var TravelsContent=""
    var CoverPhoto=""
    var UpdateTime=""
    var Views=0
    var CommentMes:CommentMeModel?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["CommentMes":CommentMeModel.self]
    }
    
}

