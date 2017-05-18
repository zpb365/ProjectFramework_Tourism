//
//  GoumaiXuzhiViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/15.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoumaiXuzhiViewModel: NSObject {
    func GetChannelsVideo(result:((_ result:Bool?,_ Conten:String?) -> Void)?){
        CommonFunction.Global_Get(entity: nil, IsListData: false, url: HttpsUrl+"api/Channels/GetPlatformBuyingTips", isHUD: false, isHUDMake: false, parameters: nil) { (resultModel) in
            if(resultModel?.Success==true){
               let str = resultModel?.Content as! String
                result?(true,str)
            }else{
                result?(false,"")
            }
        }
    }
}
