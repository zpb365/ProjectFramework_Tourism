//
//  CommentMeModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/3.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class CommentMeModel: NSObject {
    var ContentMsg=""
    var CommentTime=""
    var Score=0
    var UserID=0
    var UserInfo:UserInfoModel?
    var Photos:[Photos_List]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["UserInfo":UserInfoModel.self,"Photos":Photos_List.self]
    }
}
class UserInfoModel: NSObject {
    var UserID=0
    var UserName=""
    var NickName=""
    var UserLogo=""
    var Sex=""
}
class Photos_List: NSObject {
    var CommentID=0
    var ImgPath=""
}
