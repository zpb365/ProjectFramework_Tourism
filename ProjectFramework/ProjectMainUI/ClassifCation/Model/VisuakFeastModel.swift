//
//  VisuakFeastModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation



///视觉盛宴实体 --->  美图 ------
class ClassBeautifulPictureList: NSObject {
    var CoverPhoto=""
    var AlbumName=""
    var AlbumDescribe=""
    var Views=0
    var SubViews=0
    var UpdateTime=""
    var List:[ClassBeautifulPictureList_Item]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["List":ClassBeautifulPictureList_Item.self]
    }
    
}
class ClassBeautifulPictureList_Item: NSObject {
    var PhotoUrl=""
    var PhotoDescribe=""
    var Tab=""
    var CreateTime=""
}

///视觉盛宴实体 --->  全景 ------
class ClassPanorama360List: NSObject {
    var Title=""
    var CoverPhoto=""
    var Describe=""
    var Views=0
    var SubViews=0
    var CreateTime=""
    var List:[ClassPanorama360List_Item]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["List":ClassPanorama360List_Item.self]
    }
    
}
class ClassPanorama360List_Item: NSObject {
    var ItemName=""
    var panoramaUrl=""
}


///视觉盛宴实体 --->  VR ------
class ClassVRVideoClassList: NSObject {
    var VideoName=""
    var CoverPhoto=""
    var VideoDescribe=""
    var tab=""
    var Views=0
    var SubViews=0
    var CreateTime=""
    var List:[ClassVRVideoClassList_Item]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["List":ClassVRVideoClassList_Item.self]
    }
    
}
class ClassVRVideoClassList_Item: NSObject {
    var VideoTitle=""
    var CoverPhoto=""
    var VideoDescribe=""
    var ItemName=""
    var VideoUrl=""
}

