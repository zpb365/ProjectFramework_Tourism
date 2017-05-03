//
//  PolicyNewsViewMdeel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/21.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class PolicyNewsViewMdeel {

    var ListData = [PolicyNewsModel]()
    
    func GetChannelsNews (result:((_ result:Bool?) -> Void)?)   {
        CommonFunction.Global_Get(entity: PolicyNewsModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetChannelsNews", isHUD: false, isHUDMake: false, parameters:nil) { (resultModel) in
            if(resultModel?.Success==true){
                self.ListData = resultModel?.Content   as!  [PolicyNewsModel]
                result?(true)
            }else{
                result?(false)
            }
            
        }
    }
}
